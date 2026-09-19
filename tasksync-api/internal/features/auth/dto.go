package auth

import (
	"tasksync/internal/core/objects"
	"time"
)

type UserResponse struct {
	ID        int       `json:"id"`
	Fullname  string    `json:"fullname"`
	Email     string    `json:"email"`
	CreatedAt time.Time `json:"createdAt"`
}

type RegisterRequest struct {
	Fullname string `json:"fullname"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

func (r *RegisterRequest) Validate() error {

	_, err := objects.NewName(r.Fullname)
	if err != nil {
		return err
	}

	_, err = objects.NewEmail(r.Email)
	if err != nil {
		return err
	}

	_, err = objects.NewPassword(r.Password)
	if err != nil {
		return err
	}

	return nil
}

type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

func (r *LoginRequest) Validate() error {

	_, err := objects.NewEmail(r.Email)
	if err != nil {
		return err
	}

	_, err = objects.NewPassword(r.Password)
	if err != nil {
		return err
	}

	return nil
}

type LoginResponse struct {
	AccessToken string `json:"accessToken"`
}
