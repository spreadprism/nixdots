package cmd

import (
	"cmp"
	"fmt"
	"os/exec"
	"slices"
	"sync"

	"github.com/pkg/errors"
	"github.com/spf13/cobra"
	"golang.org/x/sync/errgroup"
)

var healthCmd = &cobra.Command{
	Use:   "health",
	Short: "verify dependencies",
	RunE: func(cmd *cobra.Command, args []string) error {
		checks, err := health()
		if err != nil {
			return errors.Wrap(err, "failed to check health")
		}

		slices.SortFunc(checks, func(c1 Check, c2 Check) int {
			return cmp.Compare(c1.name, c2.name)
		})

		for _, check := range checks {
			if check.err != nil {
				fmt.Printf("%s: FAILED: %s\n", check.name, check.err.Error())
			} else {
				fmt.Printf("%s: PASSED\n", check.name)
			}
		}
		return nil
	},
}

type Check struct {
	name string
	err  error
}

func health() ([]Check, error) {
	var eg errgroup.Group
	var mu sync.Mutex

	checks := make([]Check, 0)

	execCheck := func(name string, invalidMsg string, fn func() (bool, error)) {
		eg.Go(func() error {
			check := Check{
				name: name,
			}

			if valid, err := fn(); err != nil {
				check.err = err
			} else if !valid {
				check.err = errors.New(invalidMsg)
			}

			mu.Lock()
			checks = append(checks, check)
			mu.Unlock()

			return nil
		})
	}

	execCheck("nix", "nh command not found", func() (bool, error) {
		return CmdExists("nix"), nil
	})
	execCheck("nh", "nh command not found", func() (bool, error) {
		return CmdExists("nh"), nil
	})

	return checks, eg.Wait()
}

func CmdExists(cmd string) bool {
	_, err := exec.LookPath(cmd)
	return err == nil
}
