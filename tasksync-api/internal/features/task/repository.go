package task

import (
	"context"
	"errors"

	"gorm.io/gorm"

	"tasksync/internal/core/database"
)

type TaskRepository interface {
	FindAllByUserID(ctx context.Context, userID int) ([]*Task, error)
	FindByIDAndUserID(ctx context.Context, taskID int, userID int) (*Task, error)
	Create(ctx context.Context, task *Task) (*Task, error)
	Update(ctx context.Context, task *Task) (*Task, error)
	Delete(ctx context.Context, taskID int, userID int) error
}

type taskRepository struct {
	db *database.Database
}

func NewTaskRepository(db *database.Database) TaskRepository {
	return &taskRepository{db: db}
}

func (r *taskRepository) FindAllByUserID(ctx context.Context, userID int) ([]*Task, error) {
	var tasks []*Task
	err := r.db.WithContext(ctx).
		Where("user_id = ?", userID).
		Order("created_at desc").
		Find(&tasks).Error
	if err != nil {
		return nil, err
	}
	return tasks, nil
}

func (r *taskRepository) FindByIDAndUserID(ctx context.Context, taskID int, userID int) (*Task, error) {
	var t Task
	err := r.db.WithContext(ctx).
		Where("id = ? AND user_id = ?", taskID, userID).
		First(&t).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrTaskNotFound
		}
		return nil, err
	}
	return &t, nil
}

func (r *taskRepository) Create(ctx context.Context, task *Task) (*Task, error) {
	if err := r.db.WithContext(ctx).Create(task).Error; err != nil {
		return nil, err
	}
	return task, nil
}

func (r *taskRepository) Update(ctx context.Context, task *Task) (*Task, error) {
	result := r.db.WithContext(ctx).
		Model(&Task{}).
		Where("id = ? AND user_id = ?", task.ID, task.UserID).
		Updates(map[string]any{
			"title":       task.Title,
			"description": task.Description,
			"due_date":     task.DueDate,
			"is_complete":  task.IsComplete,
		})

	if result.Error != nil {
		return nil, result.Error
	}

	if result.RowsAffected == 0 {
		return nil, ErrTaskNotFound
	}

	return r.FindByIDAndUserID(ctx, task.ID, task.UserID)
}

func (r *taskRepository) Delete(ctx context.Context, taskID int, userID int) error {
	result := r.db.WithContext(ctx).
		Where("id = ? AND user_id = ?", taskID, userID).
		Delete(&Task{})

	if result.Error != nil {
		return result.Error
	}

	if result.RowsAffected == 0 {
		return ErrTaskNotFound
	}

	return nil
}
