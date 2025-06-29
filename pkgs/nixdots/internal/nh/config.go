package nh

import (
	"os"
	"runtime"

	"github.com/go-ini/ini"
	"github.com/pkg/errors"
	"github.com/spreadprism/nixdots/internal/config"
)

type config struct {
	FlakeRoot  string     `mapstructure:"flake-root"`
	SwitchType SwitchType `mapstructure:"switch-type"`
}

func cfg() (*config, error) {
	cfg := &config{}

	if err := internal.LoadCfg(cfg); err != nil {
		return nil, errors.Wrap(err, "failed to load configuration")
	}

	if cfg.FlakeRoot == "" {
		cwd, err := os.Getwd()
		if err != nil {
			return nil, errors.Wrap(err, "failed to get current working directory")
		}
		cfg.FlakeRoot = cwd
	}

	if cfg.SwitchType == "" {
		var err error
		cfg.SwitchType, err = detectedSwitchType()
		if err != nil {
			return nil, errors.Wrap(err, "failed to detect switch type")
		}
	}

	return cfg, nil
}

func detectedSwitchType() (SwitchType, error) {
	switch runtime.GOOS {
	case "linux":
		os, err := getOS()
		if err != nil {
			return UnknownSwitch, errors.Wrap(err, "failed to get OS")
		}
		if os == "nixos" {
			return OsSwitch, nil
		} else {
			return HomeSwitch, nil
		}
	case "darwin":
		return DarwinSwitch, nil
	}
	return UnknownSwitch, nil
}

const OS_RELEASE_PATH = "/etc/os-release"

func getOS() (string, error) {
	cfg, err := ini.Load(OS_RELEASE_PATH)
	if err != nil {
		return "", errors.Wrapf(err, "failed to load OS release file: %s", OS_RELEASE_PATH)
	}

	return cfg.Section("").Key("ID").String(), nil
}
