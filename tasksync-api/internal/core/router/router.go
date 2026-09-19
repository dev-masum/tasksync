package router

import (
	"net/http"
	"tasksync/internal/core/config"
	"tasksync/internal/core/database"
	"tasksync/internal/core/logger"
	"tasksync/internal/core/middleware"
	"tasksync/internal/core/response"
	"tasksync/internal/features/auth"
	"tasksync/internal/features/task"

	"github.com/go-chi/chi/v5"
)

type Router struct {
	cfg *config.Config
	log *logger.Logger
	db  *database.Database
	mux *chi.Mux
}

func New(cfg *config.Config, db *database.Database, log *logger.Logger) *Router {
	mux := chi.NewRouter()

	return &Router{
		cfg: cfg,
		db:  db,
		log: log,
		mux: mux,
	}
}

func (rt *Router) Handler() *chi.Mux {
	rt.mux.Use(middleware.RequestID)
	rt.mux.Use(middleware.CORS)
	rt.mux.Use(middleware.Logger(rt.log))
	rt.mux.Use(middleware.Recoverer(rt.log))

	rt.mux.Get("/health", rt.health)
	rt.mux.Get("/ready", rt.readiness)

	rt.mux.Route("/api/v1", func(r chi.Router) {
		authRouter := auth.NewRouter(rt.cfg, rt.log, rt.db)
		taskRouter := task.NewRouter(rt.cfg, rt.log, rt.db)

		r.Mount("/auth", authRouter.Routes())
		r.Mount("/tasks", taskRouter.Routes())
	})

	return rt.mux
}

func (rt *Router) health(w http.ResponseWriter, r *http.Request) {
	response.OK(w, "success", map[string]any{
		"name":   "tasksync-api",
		"status": "ok",
		"env":    rt.cfg.App.Env,
		"port":   rt.cfg.Server.Port,
	})
}

func (rt *Router) readiness(w http.ResponseWriter, r *http.Request) {
	if rt.db == nil {
		response.ServiceUnavailable(w, "database instance not initialized")
		return
	}

	if err := rt.db.Ping(); err != nil {
		response.ServiceUnavailable(w, err.Error())
		return
	}

	response.OK(w, "success", map[string]any{
		"status":   "ready",
		"database": "connected",
	})
}
