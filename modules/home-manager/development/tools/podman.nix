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
    home.file.".bin/docker".source = "${pkgs.podman}/bin/podman";
    shell.aliases = {
      pm = "podman";
      pmc = "podman compose";
    };
  };
}
