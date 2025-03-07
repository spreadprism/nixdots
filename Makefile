UNAME := $(shell uname -s)
SWITCH_FLAGS = --experimental-features 'nix-command flakes'
FLAKEARG = --flake .

ifeq ($(UNAME),Linux)
	DISTRO := $(cat /etc/os-release | grep ^ID | awk -F= '{print $2}')
	ifeq ($(DISTRO),nixos)
		# if nh is available use nh os
		ifeq ($(shell command -v nh 2> /dev/null),)
			NIXCMD = nixos-rebuild
		else
			NIXCMD = nh os
			FLAKEARG = .
		endif
	else
		ifeq ($(shell command -v nh 2> /dev/null),)
			NIXCMD = home-manager
			FLAKEARG = --flake .
		else
			NIXCMD = nh home
			FLAKEARG = .
		endif
		NIXINIT = nix run home-manager/master --experimental-features 'nix-command flakes' -- switch --flake .
	endif
else ifeq ($(UNAME),Darwin)
	# macOS-specific commands
	NIXCMD = darwin-rebuild
	NIXINIT = nix run nix-darwin/master#darwin-rebuild --experimental-features 'nix-command flakes' -- switch --flake .
endif


switch:
	@$(NIXCMD) switch $(FLAKEARG)

update: switch
	@nix flake update

init:
	@$(NIXINIT)
