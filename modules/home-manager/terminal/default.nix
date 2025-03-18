{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./ghostty.nix
  ];
  options = {
    terminal = mkOption {
      type = types.enum [false "ghostty"];
      default = false;
    };
  };
}
