package task

import (
	"errors"
	"time"
)

type CreateTaskRequest struct {
	Title       string    `json:"title"`
	Description string    `json:"description"`
	DueDate     time.Time `json:"dueDate"`
}

func (r CreateTaskRequest) Validate() error {

	if r.Title == "" {
		return errors.New("title is required")
	}

	if len(r.Title) > 255 {
		return errors.New("title must be at most 255 characters")
	}

	if r.Description == "" {
		return errors.New("description is required")
	}

	if len(r.Description) > 1000 {
		return errors.New("description must be at most 1000 characters")
	}

	if r.DueDate.IsZero() {
		return errors.New("due date is required")
	}

	return nil

}

type UpdateTaskRequest struct {
	Title       *string    `json:"title"`
	Description *string    `json:"description"`
	DueDate     *time.Time `json:"dueDate"`
	IsComplete  *bool      `json:"isComplete"`
}
