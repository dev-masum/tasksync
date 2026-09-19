package auth

import (
	"context"
	"errors"

	"golang.org/x/crypto/bcrypt"

	"tasksync/internal/core/jwt"
)

type AuthService interface {
	Register(ctx context.Context, req *RegisterRequest) error
	Login(ctx context.Context, req *LoginRequest) (*LoginResponse, error)
	Me(ctx context.Context, userID int) (*UserResponse, error)
}

type authService struct {
	userRepo     UserRepository
	tokenManager jwt.TokenManager
}

func NewAuthService(userRepo UserRepository, tokenManager jwt.TokenManager) AuthService {
	return &authService{
		userRepo:     userRepo,
		tokenManager: tokenManager,
	}
}

func (s *authService) Register(ctx context.Context, req *RegisterRequest) error {
	existing, err := s.userRepo.FindByEmail(ctx, req.Email)
	if err == nil && existing != nil {
		return ErrDuplicateEmail
	}

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	user := &User{
		Fullname: req.Fullname,
		Email:    req.Email,
		Password: string(hashedPassword),
	}

	_, err = s.userRepo.Create(ctx, user)
	if err != nil {
		return err
	}

	return nil
}

func (s *authService) Login(ctx context.Context, req *LoginRequest) (*LoginResponse, error) {
	user, err := s.userRepo.FindByEmail(ctx, req.Email)
	if err != nil {
		if errors.Is(err, ErrUserNotFound) {
			return nil, ErrInvalidCredentials
		}
		return nil, err
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.Password)); err != nil {
		return nil, ErrInvalidCredentials
	}

	tokenStr, err := s.tokenManager.Generate(user.ID, user.Email)
	if err != nil {
		return nil, err
	}

	return &LoginResponse{
		AccessToken: tokenStr,
	}, nil
}

func (s *authService) Me(ctx context.Context, userID int) (*UserResponse, error) {
	user, err := s.userRepo.FindByID(ctx, userID)
	if err != nil {
		return nil, err
	}

	return &UserResponse{
		ID:        user.ID,
		Fullname:  user.Fullname,
		Email:     user.Email,
		CreatedAt: user.CreatedAt,
	}, nil
}


