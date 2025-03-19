{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./ghostty.nix
    ./kitty.nix
  ];
  options = {
    terminal = mkOption {
      type = types.enum [false "ghostty" "kitty"];
      default = false;
    };
  };
}
