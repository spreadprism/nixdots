{ inputs, outputs, stateVersion, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      terraform
      act
    ];
  };

  # INFO: shell
  shell.zsh.enable = true;
  terminal.kitty.enable = false;
  # INFO: enable development features
  development.enable = true;
  # INFO: Cloud platform
  development.gcp.enable = true;
  # INFO: Languages
  development.go.enable = true;

}
