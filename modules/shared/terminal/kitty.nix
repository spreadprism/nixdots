{ pkgs, lib, config, flakeRoot, ... }:
let
  cfg = config.shell.zsh;
in
{
  options.terminal.kitty.enable = lib.mkEnableOption "use kitty terminal";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
    [
        kitty
    ];

    xdg.configFile."kitty/kitty.conf" = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/kitty/kitty.conf";
  };
}
