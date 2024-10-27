{ lib, pkgs, stateVersion, username, hostname, ... }:
{
  nixpkgs.config.allowUnfree = true;
  users.users.${username} = {
    isNormalUser = true;
  };
  environment.systemPackages = with pkgs;
    [
      git
    ];
  system.stateVersion = 4;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
