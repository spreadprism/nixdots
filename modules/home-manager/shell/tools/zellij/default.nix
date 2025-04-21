{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.shell.mux == "zellij";
in {
  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      zellij
    ];
    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    shell.extra = [];
  };
}
