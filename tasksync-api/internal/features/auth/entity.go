package auth

import "time"

type User struct {
	ID int `json:"id"`

	Fullname string `json:"fullname"`

	Email    string `json:"email"`
	Password string `json:"-"`

	CreatedAt time.Time  `json:"createdAt"`
	UpdatedAt time.Time  `json:"updatedAt"`
	DeletedAt *time.Time `json:"deletedAt"`
}
