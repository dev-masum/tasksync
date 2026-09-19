package objects

import (
	"errors"
	"strings"
)

type Name struct {
	value string
}

var (
	ErrNameRequired  = errors.New("name is required")
	ErrNameMinLength = errors.New("name must be at least 3 characters")
	ErrNameMaxLength = errors.New("name must be at most 255 characters")
	ErrInvalidName   = errors.New("name must contain only letters and spaces")
)

func NewName(value string) (Name, error) {
	value = strings.TrimSpace(value)

	if value == "" {
		return Name{}, ErrNameRequired
	}

	if len(value) < 3 {
		return Name{}, ErrNameMinLength
	}

	if len(value) > 255 {
		return Name{}, ErrNameMaxLength
	}

	return Name{value: value}, nil
}

func (n Name) String() string {
	return n.value
}
