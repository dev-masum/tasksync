package middleware

import (
	"fmt"
	"net/http"

	"go.uber.org/zap"

	"tasksync/internal/core/logger"
	"tasksync/internal/core/response"
)

func Recoverer(log *logger.Logger) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			defer func() {
				if rvr := recover(); rvr != nil {
					reqID := GetRequestID(r.Context())
					log.Error("panic recovered",
						zap.String("req_id", reqID),
						zap.Any("error", rvr),
						zap.String("path", r.URL.Path),
					)

					if rvr == http.ErrAbortHandler {
						panic(rvr)
					}

					response.InternalServerError(w, fmt.Sprintf("internal server error: %v", rvr))
				}
			}()

			next.ServeHTTP(w, r)
		})
	}
}
