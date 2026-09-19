package auth

import "errors"

var (
	ErrDuplicateEmail     = errors.New("email is already registered")
	ErrUserNotFound       = errors.New("user not found")
	ErrInvalidCredentials = errors.New("invalid email or password")
	ErrInvalidToken       = errors.New("invalid or expired token")
)
