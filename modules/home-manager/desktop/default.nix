{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./hyprland/hyprland.nix
  ];
  options.desktop = mkOption {
    type = types.enum [false "hyprland"];
    default = false;
  };
}
