package logger

import (
	"go.uber.org/zap"

	"tasksync/internal/core/config"
)

type Logger struct {
	*zap.Logger
}

func Initialize(env config.Environment) (*Logger, error) {
	var cfg zap.Config

	switch env {
	case config.EnvDev:
		cfg = zap.NewDevelopmentConfig()
	case config.EnvProd:
		cfg = zap.NewProductionConfig()
	default:
		cfg = zap.NewDevelopmentConfig()
	}

	logger, err := cfg.Build()
	if err != nil {
		return nil, err
	}

	return &Logger{logger}, nil
}
