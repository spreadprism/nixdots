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

<<<<<<< HEAD
    xdg.configFile."kitty/kitty.conf" = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/kitty/kitty.conf";
=======
    xdg.configFile."kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/kitty/kitty.conf";
>>>>>>> 288a1c8 (added kitty module)
  };
}
