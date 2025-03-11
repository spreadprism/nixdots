{ pkgs, lib, config, flakeRoot, username, ... }:
let
  cfg = config.development.go;
in
{
  options.development.go.enable = lib.mkEnableOption "Add python development support";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        go_1_24
      ];

    home.file.".nix/shell/go.sh".text =
    ''
    export GOPATH="$HOME/.go"
    export GOBIN="$GOPATH/bin"
    export PATH="$PATH:$GOBIN"
    '';
  };
}
