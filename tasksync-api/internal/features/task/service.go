package task

import (
	"context"
)

type TaskService interface {
	FindAll(ctx context.Context, userID int) ([]*Task, error)
	FindByID(ctx context.Context, userID int, taskID int) (*Task, error)
	Create(ctx context.Context, userID int, req *CreateTaskRequest) (*Task, error)
	Update(ctx context.Context, userID int, taskID int, req *UpdateTaskRequest) (*Task, error)
	Delete(ctx context.Context, userID int, taskID int) error
}

type taskService struct {
	taskRepo TaskRepository
}

func NewTaskService(taskRepo TaskRepository) TaskService {
	return &taskService{taskRepo: taskRepo}
}

func (s *taskService) FindAll(ctx context.Context, userID int) ([]*Task, error) {
	return s.taskRepo.FindAllByUserID(ctx, userID)
}

func (s *taskService) FindByID(ctx context.Context, userID int, taskID int) (*Task, error) {
	return s.taskRepo.FindByIDAndUserID(ctx, taskID, userID)
}

func (s *taskService) Create(ctx context.Context, userID int, req *CreateTaskRequest) (*Task, error) {
	t := &Task{
		Title:       req.Title,
		Description: req.Description,
		DueDate:     req.DueDate,
		IsComplete:  false,
		UserID:      userID,
	}

	return s.taskRepo.Create(ctx, t)
}

func (s *taskService) Update(ctx context.Context, userID int, taskID int, req *UpdateTaskRequest) (*Task, error) {
	existingTask, err := s.taskRepo.FindByIDAndUserID(ctx, taskID, userID)
	if err != nil {
		return nil, err
	}

	if req.Title != nil {
		existingTask.Title = *req.Title
	}
	if req.Description != nil {
		existingTask.Description = *req.Description
	}
	if req.DueDate != nil {
		existingTask.DueDate = *req.DueDate
	}
	if req.IsComplete != nil {
		existingTask.IsComplete = *req.IsComplete
	}

	return s.taskRepo.Update(ctx, existingTask)
}

func (s *taskService) Delete(ctx context.Context, userID int, taskID int) error {
	return s.taskRepo.Delete(ctx, taskID, userID)
}
