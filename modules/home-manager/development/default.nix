{ pkgs, lib, config, flakeRoot, username, ... }:
let
  cfg = config.development;
  args = { inherit pkgs lib config flakeRoot username; enabled = cfg.enable; };
in
{
  options.development.enable = lib.mkEnableOption "Install development tools";

  imports = [
    (import ./languages args)
    (import ./git.nix args)
    (import ./nvim.nix args)
    (import ./kubernetes.nix args)
    (import ./gcloud.nix args)
    (import ./podman.nix args)
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        grpcurl
        cargo
        nodejs_22
        pnpm
        php
        jdk17
      ];
  };
}
