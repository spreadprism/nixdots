{
  pkgs,
  lib,
  config,
  ...
}: {
  options.ruby = rec {
    enable = lib.mkEnableOption "enable ruby";
    defaults = enable;
  };

  config =
    lib.mkIf config.ruby.enable {
    };
}
