{ inputs, outputs, stateVersion, pkgs, ... }:
{
  home = {
    packages = with pkgs; [

    ];
  };

  shell.zsh.enable = true;
  development.enable = true;
  terminal.kitty.enable = true;
}
