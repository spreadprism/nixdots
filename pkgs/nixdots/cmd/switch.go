package cmd

import (
	"context"
	"errors"
	"slices"
	"strings"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
	"github.com/spreadprism/nixdots/internal"
	"github.com/spreadprism/nixdots/internal/nh"
)

var switchCmd = &cobra.Command{
	Use:    "switch",
	Short:  "Switches the current configuration.",
	PreRun: preRun,
	Args: func(cmd *cobra.Command, args []string) error {
		switch len(args) {
		case 0:
			return nil
		case 1:
			arg := args[0]
			if slices.Contains(cmd.ValidArgs, arg) {
				viper.Set("switch-type", args[0])
			} else {
				return errors.New("invalid argument provided, valid arguments are: " + strings.Join(cmd.ValidArgs, ", "))
			}
			return nil
		default:
			return errors.New("too many arguments provided")
		}
	},
	ValidArgs: []cobra.Completion{
		nh.OsSwitch,
		nh.HomeSwitch,
		nh.DarwinSwitch,
	},
	RunE: func(cmd *cobra.Command, args []string) error {
		return internal.Switch(context.Background())
	},
}
