{ lib, pkgs, stateVersion, username, hostname, ... }:
{
  nixpkgs.config.allowUnfree = true;
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  environment.systemPackages = with pkgs;
  [
  ];

  system.stateVersion = 4;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  homebrew = {
    enable = true;

    brews = [

    ];

    casks = [

    ];

    masApps = {

    };
    onActivation.cleanup = "zap";
  };
}
