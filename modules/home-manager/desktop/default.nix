{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./hyprland.nix
  ];
  options.desktop = mkOption {
    type = types.enum ["none" "hyprland"];
    default = ["none"];
  };
}
