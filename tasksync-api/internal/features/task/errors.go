package task

import "errors"

var (
	ErrTaskNotFound = errors.New("task not found or does not belong to user")
)
