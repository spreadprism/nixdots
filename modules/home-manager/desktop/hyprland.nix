{
  lib,
  config,
  flakeRoot,
  ...
}: {
  config = lib.mkIf (config.desktop == "hyprland") {
    xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/hypr";
    xdg.configFile."hyprpanel".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/hyprpanel";
  };
}
