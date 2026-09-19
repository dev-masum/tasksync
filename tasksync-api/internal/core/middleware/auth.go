package middleware

import (
	"context"
	"net/http"
	"strings"

	"tasksync/internal/core/jwt"
	"tasksync/internal/core/response"
)

type contextKey string

const (
	UserIDKey contextKey = "user_id"
	EmailKey  contextKey = "user_email"
)

func AuthGuard(tokenManager jwt.TokenManager) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			authHeader := r.Header.Get("Authorization")
			if authHeader == "" {
				response.Unauthorized(w, "missing authorization header")
				return
			}

			parts := strings.SplitN(authHeader, " ", 2)
			if len(parts) != 2 || !strings.EqualFold(parts[0], "Bearer") {
				response.Unauthorized(w, "invalid authorization header format")
				return
			}

			tokenStr := parts[1]
			claims, err := tokenManager.Verify(tokenStr)
			if err != nil {
				response.Unauthorized(w, "invalid or expired token")
				return
			}

			ctx := context.WithValue(r.Context(), UserIDKey, claims.UserID)
			ctx = context.WithValue(ctx, EmailKey, claims.Email)

			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}

// GetUserID retrieves the authenticated UserID from the request context.
func GetUserID(r *http.Request) (int, bool) {
	val := r.Context().Value(UserIDKey)
	if val == nil {
		return 0, false
	}
	id, ok := val.(int)
	return id, ok
}

