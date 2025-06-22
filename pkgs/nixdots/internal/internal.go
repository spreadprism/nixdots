package internal

import (
	"context"

	"github.com/pkg/errors"
	"github.com/spf13/viper"
	config "github.com/spreadprism/nixdots/internal/config"
	"github.com/spreadprism/nixdots/internal/nh"
)

type SwitchType = string

func init() {
	viper.SetDefault("SwitchType", "")
}

func Switch(ctx context.Context) error {
	cfg, err := config.Get()
	if err != nil {
		return errors.Wrap(err, "failed to get configuration")
	}
	nh := nh.New(cfg.FlakeRoot, cfg.SwitchType)

	if err := nh.Switch(ctx); err != nil {
		return errors.Wrap(err, "failed to switch configuration")
	}

	return nil
}
