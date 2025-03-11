{ inputs, outputs, stateVersion, pkgs, ... }:
{
  targets.genericLinux.enable = true;
  home = {
    packages = with pkgs; [

    ];
  };

  shell.zsh.enable = true;

  development.enable = true;
  development.python.enable = true;
  development.go.enable = true;

  desktop.enable = true;
  terminal.ghostty = {
    enable = true;
    install = false;
  };

}
