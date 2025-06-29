package cmd

import (
	"fmt"
	"strings"

	"github.com/pkg/errors"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var configCmd = &cobra.Command{
	Use:    "config",
	Short:  "get config value",
	PreRun: preRun,
	RunE: func(cmd *cobra.Command, args []string) error {
		_, err := fmt.Println(viper.Get(strings.Join(args, ".")))
		return errors.WithStack(err)
	},
}
