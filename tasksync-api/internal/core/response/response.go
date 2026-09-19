package response

import (
	"encoding/json"
	"net/http"
)

type Envelope struct {
	Message string `json:"message,omitempty"`
	Error   string `json:"error,omitempty"`
	Data    any    `json:"data,omitempty"`
}

func JSON(w http.ResponseWriter, status int, v any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	_ = json.NewEncoder(w).Encode(v)
}

func OK(w http.ResponseWriter, message string, data any) {
	JSON(w, http.StatusOK, Envelope{Message: message, Data: data})
}

func Created(w http.ResponseWriter, message string, data any) {
	JSON(w, http.StatusCreated, Envelope{Message: message, Data: data})
}

func NoContent(w http.ResponseWriter, message string) {
	JSON(w, http.StatusNoContent, Envelope{Message: message})
}

func BadRequest(w http.ResponseWriter, message string) {
	JSON(w, http.StatusBadRequest, Envelope{Error: message})
}

func Unauthorized(w http.ResponseWriter, message string) {
	JSON(w, http.StatusUnauthorized, Envelope{Error: message})
}

func NotFound(w http.ResponseWriter, message string) {
	JSON(w, http.StatusNotFound, Envelope{Error: message})
}

func Error(w http.ResponseWriter, status int, message string) {
	JSON(w, status, Envelope{Error: message})
}

func ValidationError(w http.ResponseWriter, message string) {
	JSON(w, http.StatusUnprocessableEntity, Envelope{Error: message})
}

func InternalServerError(w http.ResponseWriter, message string) {
	JSON(w, http.StatusInternalServerError, Envelope{Error: message})
}

func MethodNotAllowed(w http.ResponseWriter, message string) {
	JSON(w, http.StatusMethodNotAllowed, Envelope{Error: message})
}

func ServiceUnavailable(w http.ResponseWriter, message string) {
	JSON(w, http.StatusServiceUnavailable, Envelope{Error: message})
}
