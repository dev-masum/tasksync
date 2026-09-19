package objects

import (
	"errors"
	"strings"
)

var (
	ErrEmailRequired = errors.New("email is required")
	ErrInvalidEmail  = errors.New("invalid email")
)

type Email struct {
	value string
}

func NewEmail(value string) (Email, error) {
	value = strings.TrimSpace(value)

	if value == "" {
		return Email{}, ErrEmailRequired
	}

	if len(value) < 3 {
		return Email{}, ErrInvalidEmail
	}

	if len(value) > 255 {
		return Email{}, ErrInvalidEmail
	}

	return Email{value: strings.ToLower(value)}, nil
}

func (e Email) String() string {
	return e.value
}
