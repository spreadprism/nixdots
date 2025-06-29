package cmd

import (
	"fmt"
	"log/slog"
	"os"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
	"github.com/spreadprism/nixdots/internal/config"
)

var (
	Major    int  = 0
	Minor    int  = 1
	Patch    int  = 0
	Snapshot bool = true
)

func versionSuffix() string {
	if Snapshot {
		return "-snapshot"
	}
	return ""
}

var rootCmd = &cobra.Command{
	Use:           "nixdots",
	Short:         "nixdots is a helper tool to manage nix configurations",
	Version:       fmt.Sprintf("%d.%d.%d%s", Major, Minor, Patch, versionSuffix()),
	SilenceErrors: true,
	PreRun:        preRun,
}

func Execute() {
	if len(os.Args) > 1 && os.Args[1] == "--help" || os.Args[1] == "-h" {
		if err := rootCmd.Help(); err != nil {
			fmt.Fprintf(os.Stderr, "Error displaying help: %v\n", err)
			os.Exit(1)
		}
		return
	}
	cmd, _, err := rootCmd.Find(os.Args[1:])
	// default cmd if no cmd is given
	if err == nil && cmd.Use == rootCmd.Use {
		args := append([]string{switchCmd.Use}, os.Args[1:]...)
		rootCmd.SetArgs(args)
	}

	if internal.GlobalCfg().Debug {
		slog.SetLogLoggerLevel(slog.LevelDebug)
	}

	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}

func init() {
	// root cmd config
	rootCmd.SetVersionTemplate("{{.Name}} {{.Version}}\n")
	rootCmd.AddCommand(healthCmd, switchCmd, configCmd)

	// flags
	flags := rootCmd.PersistentFlags()

	flags.Bool("debug", false, "set loglevel to debug")
	if err := viper.BindPFlag("debug", flags.Lookup("debug")); err != nil {
		fmt.Fprintf(os.Stderr, "Error binding flag: %v\n", err)
		os.Exit(1)
	}
}

func preRun(cmd *cobra.Command, args []string) {
	checks, err := health()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error checking health: %v\n", err)
		os.Exit(1)
	}

	exit := false
	// filter checks with nil error
	for _, check := range checks {
		if check.err != nil {
			if !exit {
				fmt.Fprintf(os.Stderr, "Unable to exec due to the following errors:\n")
			}
			fmt.Fprintf(os.Stderr, " - %s: %s\n", check.name, check.err.Error())
			exit = true
		}
	}

	if exit {
		os.Exit(1)
	}
}
