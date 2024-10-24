{ inputs, outputs, stateVersion, pkgs, ... }:
{
  home = {
    packages = with pkgs; [

    ];
  };

  shell.zsh.enable = true;
}
