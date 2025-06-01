{
  pkgs,
  lib,
  config,
  ...
}: {
  options.java.enable = lib.mkEnableOption "add java support";
  config = lib.mkIf config.java.enable {
    home.packages = with pkgs; [
      gradle
      maven
    ];
    shell.paths = [
    ];
  };
}
