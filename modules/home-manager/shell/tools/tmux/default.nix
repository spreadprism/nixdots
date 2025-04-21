{
  pkgs,
  lib,
  config,
  ...
}: let
  enabled = config.shell.mux == "tmux";
in {
  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      tmux
    ];
    xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
    xdg.configFile."tmux/scripts/auto_tpm_install".source = ./scripts/auto_tpm_install;
    shell.extra = [
      (builtins.readFile ./utils.sh)
    ];
  };
}
