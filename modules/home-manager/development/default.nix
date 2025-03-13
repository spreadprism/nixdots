{ pkgs, lib, config, flakeRoot, username, ... }:
let
  cfg = config.development;
  args = { inherit pkgs lib config flakeRoot username; enabled = cfg.enable; };
in
{
  options.development.enable = lib.mkEnableOption "Install development tools";

  imports = [
    (import ./nvim.nix args)
    (import ./git.nix args)
    (import ./kubernetes.nix args)
    (import ./languages args)
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        cargo
        nodejs_22
        pnpm
        grpcurl
        php
        jdk17
      ];
  };
}
