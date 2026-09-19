package task

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
	taskRouter := chi.NewRouter()

	tokenManager := jwt.New(r.cfg.Auth.JWTSecret, r.cfg.Auth.JWTExpiresInHours)
	taskRouter.Use(middleware.AuthGuard(tokenManager))

	taskRepo := NewTaskRepository(r.db)
	taskService := NewTaskService(taskRepo)
	taskHandler := NewTaskHandler(taskService)

	taskRouter.Get("/", taskHandler.FindAll)
	taskRouter.Get("/{id}", taskHandler.FindByID)
	taskRouter.Post("/", taskHandler.Create)
	taskRouter.Patch("/{id}", taskHandler.Update)
	taskRouter.Delete("/{id}", taskHandler.Remove)

	return taskRouter
}
