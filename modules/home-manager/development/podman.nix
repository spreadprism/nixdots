{
  pkgs,
  config,
  lib,
  ...
}: let
  devEnabled = config.development.enable;
in {
  config = lib.mkIf devEnabled {
    home.packages = with pkgs; [
      podman
      podman-compose
    ];
  };
}
