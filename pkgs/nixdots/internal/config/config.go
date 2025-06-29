package internal

import (
	"fmt"
	"os"
	"path"

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
	viper.SetConfigName("nixdots")
	viper.SetConfigType("yaml")

	home := os.Getenv("HOME")
	viper.AddConfigPath(os.Getenv("PWD"))
	viper.AddConfigPath(home)
	viper.AddConfigPath(path.Join(home, ".config", "nixdots"))
	viper.AddConfigPath(path.Join(os.Getenv("XDG_CONFIG_HOME"), "nixdots"))

	viper.SetEnvPrefix("nixdots")
	viper.AutomaticEnv()
	if err := viper.ReadInConfig(); err != nil {
		fmt.Fprintln(os.Stderr, errors.Wrap(err, "failed to read configuration file"))
		os.Exit(1)
	}
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
