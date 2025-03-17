{
  lib,
  pkgs,
  stateVersion,
  config,
  username,
  hostname,
  ...
}: {
  networking.hostName = hostname;
  # Enable networking
  networking.networkmanager.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  system.stateVersion = stateVersion;
}
