{ lib, pkgs, stateVersion, username, hostname, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs;
    [
      git
    ];
  system.stateVersion = 4;
  nix.useDaemon = true;
}
