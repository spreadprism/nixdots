{
  pkgs,
  lib,
  config,
  flakeRoot,
  ...
}: let
  cfg = config.terminal.kitty;
in {
  options.terminal.kitty = {
    enable = lib.mkEnableOption "use kitty terminal";
    install = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      if cfg.install
      then [
        kitty
      ]
      else [];
    xdg.configFile."kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/kitty/kitty.conf";
  };
}
