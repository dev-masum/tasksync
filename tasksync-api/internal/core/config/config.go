package config

import (
	"fmt"
	"os"
	"strconv"
)

type Environment string

const (
	EnvProd Environment = "production"
	EnvDev  Environment = "development"
)

type AppConfig struct {
	Env Environment
}

type ServerConfig struct {
	Port string
}

type DatabaseConfig struct {
	Host     string
	Port     string
	UserName string
	Password string
	Database string
	SSLMode  string

	MaxIdleConns    int
	MaxOpenConns    int
	ConnMaxLifetime int
}

func (cfg *DatabaseConfig) DSN() string {
	return fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=%s", cfg.Host, cfg.Port, cfg.UserName, cfg.Password, cfg.Database, cfg.SSLMode)
}

type AuthConfig struct {
	JWTSecret         string
	JWTExpiresInHours int
}

type Config struct {
	App      AppConfig
	Server   ServerConfig
	Database DatabaseConfig
	Auth     AuthConfig
}

func Load() *Config {
	return &Config{
		App: AppConfig{
			Env: Environment(env("ENV", string(EnvDev))),
		},
		Server: ServerConfig{
			Port: env("PORT", "3000"),
		},
		Database: DatabaseConfig{
			Host:     env("DATABASE_HOST", "localhost"),
			Port:     env("DATABASE_PORT", "5432"),
			UserName: env("DATABASE_USER", "postgres"),
			Password: env("DATABASE_PASSWORD", "postgres"),
			Database: env("DATABASE_NAME", "tasksync"),
			SSLMode:  env("DATABASE_SSLMODE", "disable"),

			MaxIdleConns:    envInt("DATABASE_MAX_IDLE_CONNS", 10),
			MaxOpenConns:    envInt("DATABASE_MAX_OPEN_CONNS", 100),
			ConnMaxLifetime: envInt("DATABASE_CONN_MAX_LIFETIME", 300),
		},
		Auth: AuthConfig{
			JWTSecret:         env("JWT_SECRET", ""),
			JWTExpiresInHours: envInt("JWT_EXPIRES_IN_HOUR", 24),
		},
	}
}

func env(key string, fallback string) string {
	if val, ok := os.LookupEnv(key); ok && val != "" {
		return val
	}
	return fallback
}

func envInt(key string, fallback int) int {
	if val, ok := os.LookupEnv(key); ok && val != "" {
		if ival, err := strconv.Atoi(val); err == nil {
			return ival
		}
	}
	return fallback
}
