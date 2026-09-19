package middleware

import (
	"context"
	"net/http"

	"tasksync/internal/core/uuid"
)

type requestIDKey string

const (
	RequestIDHeader     = "X-Request-ID"
	RequestIDContextKey requestIDKey = "request_id"
)

func RequestID(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		reqID := r.Header.Get(RequestIDHeader)
		if reqID == "" {
			reqID = uuid.NewV4()
		}

		w.Header().Set(RequestIDHeader, reqID)
		ctx := context.WithValue(r.Context(), RequestIDContextKey, reqID)
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}

func GetRequestID(ctx context.Context) string {
	if val, ok := ctx.Value(RequestIDContextKey).(string); ok {
		return val
	}
	return ""
}

