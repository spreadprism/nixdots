package nh

import (
	"context"
	"log/slog"
	"os"
	"os/exec"

	"github.com/pkg/errors"
)

func execute(ctx context.Context, dir string, args ...string) error {
	cmd := exec.CommandContext(ctx, "nh", args...)
	// pass stdin and out

	cmd.Dir = dir
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	return cmd.Run()
}

type SwitchType = string

const (
	UnknownSwitch SwitchType = "unknown"
	HomeSwitch    SwitchType = "home"
	OsSwitch      SwitchType = "os"
	DarwinSwitch  SwitchType = "darwin"
)

func Switch(ctx context.Context) error {
	cfg, err := cfg()
	if err != nil {
		return errors.WithStack(err)
	}
	if cfg.SwitchType == UnknownSwitch {
		return errors.New("unknown switch type, please set the switch type using --switch-type flag or setting it in the config")
	}
	slog.Debug("Switch", slog.String("flake-root", cfg.FlakeRoot), slog.String("switch-type", cfg.SwitchType))
	return execute(ctx, cfg.FlakeRoot, cfg.SwitchType, "switch", ".")
}
