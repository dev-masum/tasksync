package auth

import (
	"tasksync/internal/core/config"
	"tasksync/internal/core/database"
	"tasksync/internal/core/jwt"
	"tasksync/internal/core/logger"
	"tasksync/internal/core/middleware"

	"github.com/go-chi/chi/v5"
)

type Router struct {
	cfg *config.Config
	log *logger.Logger
	db  *database.Database
}

func NewRouter(cfg *config.Config, log *logger.Logger, db *database.Database) *Router {
	return &Router{cfg: cfg, log: log, db: db}
}

func (r *Router) Routes() chi.Router {

	tokenManager := jwt.New(r.cfg.Auth.JWTSecret, r.cfg.Auth.JWTExpiresInHours)

	userRepo := NewUserRepository(r.db)
	authService := NewAuthService(userRepo, tokenManager)
	authHandler := NewAuthHandler(authService)

	authRouter := chi.NewRouter()

	authRouter.Post("/register", authHandler.Register)
	authRouter.Post("/login", authHandler.Login)
	authRouter.With(middleware.AuthGuard(tokenManager)).Get("/me", authHandler.Me)

	return authRouter
}

