{ pkgs, dotfiles, ... }:
{
  targets.genericLinux.enable = true; # Enable for non nixos

  home.packages = with pkgs; [
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
