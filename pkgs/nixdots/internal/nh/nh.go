package nh

import (
	"context"
	"os"
	"os/exec"
)

type Nh interface {
	Switch(ctx context.Context) error
}

type Platform = string

type nh struct {
	flakeRoot string
	platform  Platform
}

func New(flakeRoot string, platform Platform) Nh {
	return &nh{
		flakeRoot: flakeRoot,
		platform:  platform,
	}
}

func execute(ctx context.Context, dir string, args ...string) error {
	cmd := exec.CommandContext(ctx, "nh", args...)
	// pass stdin and out

	cmd.Dir = dir
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	return cmd.Run()
}

func (n *nh) Switch(ctx context.Context) error {
	return execute(ctx, n.flakeRoot, n.platform, "switch")
}
