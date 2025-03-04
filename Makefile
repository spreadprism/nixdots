UNAME := $(shell uname -s)
ifeq ($(UNAME),Linux)
	DISTRO := $(cat /etc/os-release | grep ^ID | awk -F= '{print $2}')
	ifeq ($(DISTRO),nixos)
		SWITCH_CMD = home-manager switch --flake .
	else
		SWITCH_CMD = home-manager switch --flake .
	endif
else ifeq ($(UNAME),Darwin)
	# macOS-specific commands
	SWITCH_CMD = darwin-rebuild switch --flake .
else
	# Default commands for other systems
	SWITCH_CMD = echo "Unable to switch - Unsupported OS: $(UNAME)"
endif


switch:
	@$(SWITCH_CMD)
