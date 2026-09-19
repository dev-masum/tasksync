package task

import "time"

type Task struct {
	ID     int `json:"id"`
	UserID int `json:"userId"`

	Title       string `json:"title"`
	Description string `json:"description"`

	DueDate    time.Time `json:"dueDate"`
	IsComplete bool      `json:"isComplete"`

	CreatedAt time.Time  `json:"createdAt"`
	UpdatedAt time.Time  `json:"updatedAt"`
	DeletedAt *time.Time `json:"deletedAt"`
}
