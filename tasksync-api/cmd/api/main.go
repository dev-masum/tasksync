package main

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	_ "github.com/lib/pq"
	"go.uber.org/zap"

	"tasksync/internal/core/config"
	"tasksync/internal/core/database"
	"tasksync/internal/core/logger"
	"tasksync/internal/core/server"
)

func main() {
	// Load configuration.
	cfg := config.Load()

	// Initialize logger.
	log, err := logger.Initialize(cfg.App.Env)
	if err != nil {
		panic(fmt.Errorf("failed to initialize logger: %w", err))
	}
	defer func() {
		if err := log.Sync(); err != nil {
			fmt.Printf("logger.Sync() error: %v\n", err)
		}
	}()

	// Initialize database.
	db, err := database.Connect(&cfg.Database)
	if err != nil {
		log.Fatal("failed to connect to database", zap.Error(err))
	}
	defer func() {
		if err := db.Close(); err != nil {
			log.Error("failed to close database", zap.Error(err))
		}
	}()

	// Create and Start Server engine.
	srv := server.New(cfg, log, db)
	serverErr := make(chan error, 1)

	go func() {
		if err := srv.Start(); err != nil && err != http.ErrServerClosed {
			serverErr <- err
		}
	}()

	// Listen for shutdown signals.
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	defer signal.Stop(quit)

	select {
	case err := <-serverErr:
		log.Fatal("server failed to start", zap.Error(err))

	case sig := <-quit:
		log.Info("shutdown signal received", zap.String("signal", sig.String()))
	}

	// Graceful shutdown.
	log.Info("shutting down server gracefully")

	ctx, cancel := context.WithTimeout(
		context.Background(),
		10*time.Second,
	)
	defer cancel()

	if err := srv.Shutdown(ctx); err != nil {
		log.Error("server graceful shutdown failed", zap.Error(err))
	}

	log.Info("server exited cleanly")
}
