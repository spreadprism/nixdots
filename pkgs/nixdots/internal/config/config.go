package internal

import (
	"fmt"
	"os"

	"github.com/pkg/errors"
	"github.com/spf13/viper"
)

type GlobalConfig struct {
	Debug bool `mapstructure:"debug"`
}

func GlobalCfg() *GlobalConfig {
	cfg := &GlobalConfig{
		Debug: false,
	}
	MustLoadCfg(cfg)
	return cfg
}

func init() {
	// INFO: CONFIG
	viper.SetConfigFile("nixdots")
	viper.SetConfigType("yaml")
	viper.AddConfigPath("$HOME")
	viper.AddConfigPath("$XDG_CONFIG_HOME/nixdots")
	viper.AddConfigPath("$HOME/.config/nixdots")
	viper.AddConfigPath(os.Getenv("PWD"))

	viper.SetEnvPrefix("nixdots")
	viper.AutomaticEnv()
}

func LoadCfg[T any](base *T) error {
	return viper.Unmarshal(base)
}

func MustLoadCfg[T any](base *T) {
	if err := LoadCfg(base); err != nil {
		fmt.Fprintln(os.Stderr, errors.Wrap(err, "failed to load configuration"))
		os.Exit(1)
	}
}
