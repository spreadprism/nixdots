{
  pkgs,
  lib,
  config,
  ...
}: {
  options.rust.enable = lib.mkEnableOption "add rust support";
  config = lib.mkIf config.rust.enable {
    home.packages = with pkgs; [
      cargo
      rustc
    ];
    shell.paths = [
      "$HOME/.cargo/bin"
    ];
  };
}
