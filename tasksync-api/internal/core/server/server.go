package server

import (
	"context"
	"fmt"
	"net/http"

	"tasksync/internal/core/config"
	"tasksync/internal/core/database"
	"tasksync/internal/core/logger"
	"tasksync/internal/core/router"
)

type Server struct {
	cfg *config.Config
	log *logger.Logger
	db  *database.Database
	srv *http.Server
}

func New(cfg *config.Config, log *logger.Logger, db *database.Database) *Server {

	router := router.New(cfg, db, log)

	srv := &http.Server{
		Addr:    fmt.Sprintf(":%s", cfg.Server.Port),
		Handler: router.Handler(),
	}

	s := &Server{cfg: cfg, log: log, db: db, srv: srv}

	return s
}

func (s *Server) Start() error {
	return s.srv.ListenAndServe()
}

func (s *Server) Shutdown(ctx context.Context) error {
	return s.srv.Shutdown(ctx)
}
