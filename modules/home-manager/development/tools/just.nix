{
  pkgs,
  config,
  lib,
  ...
}: let
  devEnabled = config.development.enable;
in {
  config = lib.mkIf devEnabled {
    shell.aliases.j = "just";
    home.packages = with pkgs; [
      just
    ];
  };
}
