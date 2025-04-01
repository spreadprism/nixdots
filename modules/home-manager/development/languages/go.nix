{
  pkgs,
  lib,
  config,
  ...
}: {
  options.go = rec {
    enable = lib.mkEnableOption "enable go";
    pkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.go;
    };
    defaults = enable;
  };

  config = lib.mkIf config.go.enable {
    home.packages = with pkgs; [
      config.go.pkg
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
    xdg.home.".golangci.yml".source = ''
      version: "2"
    '';
  };
}
