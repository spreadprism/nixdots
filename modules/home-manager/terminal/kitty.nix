{ pkgs, lib, config, flakeRoot, ... }:
let
  cfg = config.terminal.kitty;
in
{
  options.terminal.kitty.enable = lib.mkEnableOption "use kitty terminal";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
    [
        kitty
    ];
    xdg.configFile."kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/kitty/kitty.conf";
  };
}
