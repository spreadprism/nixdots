{ pkgs, lib, config, flakeRoot, ... }:
let
  desktop_enable = config.desktop.enable;
in
{
  config = lib.mkIf desktop_enable {
    home.packages = with pkgs;
      [
      ];

    xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/hypr";
  };
}
