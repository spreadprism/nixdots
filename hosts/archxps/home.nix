{ inputs, outputs, stateVersion, pkgs, ... }:
{
  targets.genericLinux.enable = true;
  home = {
    packages = with pkgs; [

    ];
  };

  shell.zsh.enable = true;
}
