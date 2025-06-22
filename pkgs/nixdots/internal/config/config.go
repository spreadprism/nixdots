package internal

import (
	"os"

	"github.com/spf13/viper"
)

type Config struct {
	FlakeRoot  string `mapstructure:"flake-root"`
	SwitchType string `mapstructure:"switch-type"`
}

var c *Config = nil

func init() {
	// CONFIG
	viper.SetConfigFile("nixdots")
	viper.SetConfigType("yaml")
	viper.AddConfigPath("$HOME")
	viper.AddConfigPath("$XDG_CONFIG_HOME/nixdots")
	viper.AddConfigPath("$HOME/.config/nixdots")

	// DEFAULTS
	// get cwd
	viper.SetDefault("flake-root", os.Getenv("PWD")) // current location
}

func Get() (*Config, error) {
	var err error = nil
	if c == nil {
		err = viper.Unmarshal(&c)
	}

	return c, err
}
