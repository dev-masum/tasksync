package jwt

import (
	"errors"
	"fmt"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

var (
	ErrInvalidToken = errors.New("invalid or expired token")
	ErrExpiredToken = errors.New("token has expired")
)

type Claims struct {
	UserID int    `json:"userId"`
	Email  string `json:"email"`
}

type TokenManager interface {
	Generate(userID int, email string) (string, error)
	Verify(tokenStr string) (*Claims, error)
}

type jwtManager struct {
	secretKey     []byte
	expiresInHour int
}

func New(secret string, expiresInHour int) TokenManager {
	if expiresInHour <= 0 {
		expiresInHour = 24
	}
	return &jwtManager{
		secretKey:     []byte(secret),
		expiresInHour: expiresInHour,
	}
}

func (m *jwtManager) Generate(userID int, email string) (string, error) {
	now := time.Now()
	claims := jwt.MapClaims{
		"userId": userID,
		"email":  email,
		"exp":    now.Add(time.Duration(m.expiresInHour) * time.Hour).Unix(),
		"iat":    now.Unix(),
		"nbf":    now.Unix(),
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenStr, err := token.SignedString(m.secretKey)
	if err != nil {
		return "", fmt.Errorf("failed to sign jwt token: %w", err)
	}

	return tokenStr, nil
}

func (m *jwtManager) Verify(tokenStr string) (*Claims, error) {
	token, err := jwt.Parse(
		tokenStr,
		func(token *jwt.Token) (interface{}, error) {
			return m.secretKey, nil
		},
		jwt.WithValidMethods([]string{jwt.SigningMethodHS256.Name}),
		jwt.WithExpirationRequired(),
	)

	if err != nil {
		if errors.Is(err, jwt.ErrTokenExpired) {
			return nil, ErrExpiredToken
		}
		return nil, ErrInvalidToken
	}

	mapClaims, ok := token.Claims.(jwt.MapClaims)
	if !ok || !token.Valid {
		return nil, ErrInvalidToken
	}

	userIDFloat, ok1 := mapClaims["userId"].(float64)
	email, ok2 := mapClaims["email"].(string)
	if !ok1 || !ok2 {
		return nil, ErrInvalidToken
	}

	return &Claims{
		UserID: int(userIDFloat),
		Email:  email,
	}, nil
}
