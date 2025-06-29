package internal

import (
	"context"

	"github.com/pkg/errors"
	"github.com/spreadprism/nixdots/internal/nh"
)

type SwitchType = string

func Switch(ctx context.Context) error {
	if err := nh.Switch(ctx); err != nil {
		return errors.Wrap(err, "failed to switch configuration")
	}

	return nil
}
