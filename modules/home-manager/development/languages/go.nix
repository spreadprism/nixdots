{ pkgs, lib, config, flakeRoot, username, ... }:
let
  cfg = config.development.go;
in
{
  options.development.go.enable = lib.mkEnableOption "Install go";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        go_1_24
      ] ++ lib.optionals config.development.enable [
        gopls
        golangci-lint
        delve
      ];

    home.file.".nix/shell/go.sh".text =
    ''
    export GOPATH="$HOME/.go"
    export GOBIN="$GOPATH/bin"
    export PATH="$PATH:$GOBIN"
    '';
  };
}
