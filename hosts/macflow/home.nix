{ inputs, outputs, stateVersion, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      terraform
      act
    ];
  };

  shell.zsh.enable = true;

  development.enable = true;
  development.go.enable = true;

  terminal.kitty.enable = false;
}
