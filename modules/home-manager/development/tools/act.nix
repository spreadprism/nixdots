{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) types mkIf mkOption;
  inherit (pkgs.stdenv) isDarwin;
  actrc = lib.concatStringsSep "\n" (
    config.tools.act.flags
    ++ [
      "--env GITHUB_TOKEN=$(gh auth token)"
    ]
    ++ lib.optionals (pkgs.system == "aarch64-darwin") [
      ''--container-architecture linux/amd64''
    ]
  );
in {
  options.tools.act = {
    flags = mkOption {
      type = with types; listOf str;
      default = [];
    };
  };
  config = mkIf config.development.enable {
    home = {
      packages = with pkgs; [
        act
      ];
      file = mkIf isDarwin {
        "Library/Application Support/act/actrc".text = actrc;
      };
    };

    xdg = mkIf (!isDarwin) {
      configFile."act/actrc".text = actrc;
    };
  };
}
