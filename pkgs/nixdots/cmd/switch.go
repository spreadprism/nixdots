package cmd

import (
	"context"

	"github.com/spf13/cobra"
	"github.com/spreadprism/nixdots/internal"
)

var switchCmd = &cobra.Command{
	Use:    "switch",
	Short:  "Switches the current configuration.",
	PreRun: preRun,
	RunE: func(cmd *cobra.Command, args []string) error {
		return internal.Switch(context.Background())
	},
}
