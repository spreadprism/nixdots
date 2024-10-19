{ pkgs, user, stateVersion, ... }:
{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      pkgs.hello
    ];
  };

  programs = {};

  home.stateVersion = stateVersion;

  zsh = {
    enable = true;
  };

  programs.neovim.enable = true;
}
