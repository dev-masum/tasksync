package uuid

import (
	"github.com/google/uuid"
)

// NewV4 generates a new RFC 4122 random UUID (Version 4) string.
func NewV4() string {
	return uuid.NewString()
}

// IsValid checks whether a string is a valid UUID format.
func IsValid(s string) bool {
	_, err := uuid.Parse(s)
	return err == nil
}
