{ pkgs, lib, config, flakeRoot, username, ... }:
let
  cfg = config.development;
  args = { inherit pkgs lib config flakeRoot username; enabled = cfg.enable; };
in
{
  options.development.enable = lib.mkEnableOption "Use development tools";

  imports = [
    (import ./nvim.nix args)
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        # TODO: Remove version to computer specific
        cargo
        nodejs_22
        pnpm
        go
        wget
        php
        jdk17
      ];
  };
}
