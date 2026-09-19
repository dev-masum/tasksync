package objects

import (
	"errors"
	"strings"
)

var (
	ErrPasswordRequired  = errors.New("password is required")
	ErrPasswordMinLength = errors.New("password must be at least 6 characters")
	ErrPasswordMaxLength = errors.New("password must be at most 255 characters")
	ErrPasswordInvalid   = errors.New("password must contain at least one uppercase letter, one lowercase letter, one number, and one special character")
)

type Password struct {
	value string
}

func NewPassword(value string) (Password, error) {
	value = strings.TrimSpace(value)

	if value == "" {
		return Password{}, ErrPasswordRequired
	}

	if len(value) < 6 {
		return Password{}, ErrPasswordMinLength
	}

	if len(value) > 255 {
		return Password{}, ErrPasswordMaxLength
	}

	return Password{value: value}, nil
}

func (p Password) Value() string {
	return p.value
}
