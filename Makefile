UNAME := $(shell uname -s)
ifeq ($(UNAME),Linux)
	DISTRO := $(cat /etc/os-release | grep ^ID | awk -F= '{print $2}')
	ifeq ($(DISTRO),nixos)
		NIXCMD = nixos-rebuild
	else
		NIXCMD = home-manager
	endif
else ifeq ($(UNAME),Darwin)
	# macOS-specific commands
	NIXCMD = darwin-rebuild
endif


switch: update
	@$(NIXCMD) switch --flake .

update:
	@nix flake update
