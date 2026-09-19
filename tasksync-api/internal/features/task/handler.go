package task

import (
	"encoding/json"
	"errors"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"

	"tasksync/internal/core/middleware"
	"tasksync/internal/core/response"
)

type TaskHandler struct {
	taskService TaskService
}

func NewTaskHandler(taskService TaskService) *TaskHandler {
	return &TaskHandler{taskService: taskService}
}

func (h *TaskHandler) FindAll(w http.ResponseWriter, r *http.Request) {
	userID, ok := middleware.GetUserID(r)
	if !ok {
		response.Unauthorized(w, "unauthorized access")
		return
	}

	tasks, err := h.taskService.FindAll(r.Context(), userID)
	if err != nil {
		response.InternalServerError(w, err.Error())
		return
	}

	response.OK(w, "success", tasks)
}

func (h *TaskHandler) FindByID(w http.ResponseWriter, r *http.Request) {
	userID, ok := middleware.GetUserID(r)
	if !ok {
		response.Unauthorized(w, "unauthorized access")
		return
	}

	taskIDStr := chi.URLParam(r, "id")
	taskID, err := strconv.Atoi(taskIDStr)
	if err != nil || taskID <= 0 {
		response.BadRequest(w, "invalid task ID param")
		return
	}

	t, err := h.taskService.FindByID(r.Context(), userID, taskID)
	if err != nil {
		if errors.Is(err, ErrTaskNotFound) {
			response.NotFound(w, "Task with id "+taskIDStr+" not found or does not belong to you")
			return
		}
		response.InternalServerError(w, err.Error())
		return
	}

	response.OK(w, "success", t)
}

func (h *TaskHandler) Create(w http.ResponseWriter, r *http.Request) {
	userID, ok := middleware.GetUserID(r)
	if !ok {
		response.Unauthorized(w, "unauthorized access")
		return
	}

	var req CreateTaskRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		response.BadRequest(w, "invalid JSON payload")
		return
	}

	if err := req.Validate(); err != nil {
		response.BadRequest(w, err.Error())
		return
	}

	t, err := h.taskService.Create(r.Context(), userID, &req)
	if err != nil {
		response.InternalServerError(w, err.Error())
		return
	}

	response.Created(w, "task created successfully", t)
}

func (h *TaskHandler) Update(w http.ResponseWriter, r *http.Request) {
	userID, ok := middleware.GetUserID(r)
	if !ok {
		response.Unauthorized(w, "unauthorized access")
		return
	}

	taskIDStr := chi.URLParam(r, "id")
	taskID, err := strconv.Atoi(taskIDStr)
	if err != nil || taskID <= 0 {
		response.BadRequest(w, "invalid task ID param")
		return
	}

	var req UpdateTaskRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		response.BadRequest(w, "invalid JSON payload")
		return
	}

	t, err := h.taskService.Update(r.Context(), userID, taskID, &req)
	if err != nil {
		if errors.Is(err, ErrTaskNotFound) {
			response.NotFound(w, "Task with id "+taskIDStr+" not found or does not belong to you")
			return
		}
		response.InternalServerError(w, err.Error())
		return
	}

	response.OK(w, "task updated successfully", t)
}

func (h *TaskHandler) Remove(w http.ResponseWriter, r *http.Request) {
	userID, ok := middleware.GetUserID(r)
	if !ok {
		response.Unauthorized(w, "unauthorized access")
		return
	}

	taskIDStr := chi.URLParam(r, "id")
	taskID, err := strconv.Atoi(taskIDStr)
	if err != nil || taskID <= 0 {
		response.BadRequest(w, "invalid task ID param")
		return
	}

	err = h.taskService.Delete(r.Context(), userID, taskID)
	if err != nil {
		if errors.Is(err, ErrTaskNotFound) {
			response.NotFound(w, "Task with id "+taskIDStr+" not found or does not belong to you")
			return
		}
		response.InternalServerError(w, err.Error())
		return
	}

	response.OK(w, "Task deleted successfully", nil)
}
