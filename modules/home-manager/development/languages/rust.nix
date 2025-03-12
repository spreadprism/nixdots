{ pkgs, lib, config, flakeRoot, username, ... }:
let
  cfg = config.development.rust;
in
{
  options.development.rust.enable = lib.mkEnableOption "Add rust development support";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        cargo
        rustc
      ] ++ lib.optionals config.development.enable [
        rustfmt
      ];
  };
}
