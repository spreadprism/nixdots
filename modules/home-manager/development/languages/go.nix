{
  pkgs,
  lib,
  config,
  ...
}: {
  options.go = lib.mkEnableOption "enable go";

  config = lib.mkIf config.go {
    home.packages = with pkgs;
      [
        go_1_24
      ]
      ++ lib.optionals config.development.enable [
        gopls
        golangci-lint
        delve
      ];

    shell = {
      paths = [
        "$GOBIN"
      ];
      extra = [
        "export GOPATH=$HOME/.go"
        "export GOBIN=$GOPATH/bin"
      ];
    };
  };
}
