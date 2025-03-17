{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./ghostty.nix
  ];
  options = {
    terminal = mkOption {
      type = types.listOf (types.enum ["" "ghostty"]);
      default = "";
    };
  };
}
