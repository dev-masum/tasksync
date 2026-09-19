package auth

import (
	"encoding/json"
	"errors"
	"net/http"

	"tasksync/internal/core/middleware"
	"tasksync/internal/core/response"
)

type AuthHandler struct {
	authService AuthService
}

func NewAuthHandler(authService AuthService) *AuthHandler {
	return &AuthHandler{authService: authService}
}

func (h *AuthHandler) Register(w http.ResponseWriter, r *http.Request) {
	var req RegisterRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		response.BadRequest(w, "invalid JSON payload")
		return
	}

	if err := req.Validate(); err != nil {
		response.BadRequest(w, err.Error())
		return
	}

	err := h.authService.Register(r.Context(), &req)
	if err != nil {
		if errors.Is(err, ErrDuplicateEmail) {
			response.Error(w, http.StatusConflict, err.Error())
			return
		}
		response.InternalServerError(w, err.Error())
		return
	}

	response.Created(w, "user registered successfully", nil)
}

func (h *AuthHandler) Login(w http.ResponseWriter, r *http.Request) {
	var req LoginRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		response.BadRequest(w, "invalid JSON payload")
		return
	}

	if err := req.Validate(); err != nil {
		response.BadRequest(w, err.Error())
		return
	}

	res, err := h.authService.Login(r.Context(), &req)
	if err != nil {
		if errors.Is(err, ErrInvalidCredentials) {
			response.Unauthorized(w, err.Error())
			return
		}
		response.InternalServerError(w, err.Error())
		return
	}

	response.OK(w, "login successful", res)
}

func (h *AuthHandler) Me(w http.ResponseWriter, r *http.Request) {
	userID, ok := middleware.GetUserID(r)
	if !ok {
		response.Unauthorized(w, "unauthorized access")
		return
	}

	user, err := h.authService.Me(r.Context(), userID)
	if err != nil {
		if errors.Is(err, ErrUserNotFound) {
			response.NotFound(w, "user profile not found")
			return
		}
		response.InternalServerError(w, err.Error())
		return
	}

	response.OK(w, "user profile retrieved", user)
}

