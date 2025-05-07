{
  pkgs,
  lib,
  config,
  ...
}: {
  options.scala = rec {
    enable = lib.mkEnableOption "enable scala";
    defaults = enable;
  };

  config = lib.mkIf config.ruby.enable {
    home.packages = with pkgs; [
      sbt
    ];
  };
}
