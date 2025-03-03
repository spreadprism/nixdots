{ pkgs, lib, config, flakeRoot, username, ... }:
let
  cfg = config.development;
  args = { inherit pkgs lib config flakeRoot username; enabled = cfg.enable; };
in
{
  options.desktop.enable = lib.mkEnableOption "Configure desktop";

  imports = [
    (import ./hyprland.nix args)
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        # TODO: Remove version to computer specific
        cargo
        nodejs_22
        pnpm
        go_1_24
        wget
        php
        jdk17
      ];
  };
}
