{
  pkgs,
  username,
  outputs,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.stable-packages
    ];
  };
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
  system.primaryUser = username;
  nix.enable = false;

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = 4;
  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # Adds darwin-rebuild
  homebrew = {
    enable = true;

    brews = [
    ];

    casks = [
      "kitty"
    ];

    masApps = {
    };
    onActivation.cleanup = "zap";
  };
}
