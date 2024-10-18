{ pkgs, user, stateVersion, ... }:
{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
    ];
  };

  programs = {};

  home.stateVersion = stateVersion;

  zsh = {
    enable = true;
  };

}
