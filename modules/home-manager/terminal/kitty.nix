{
  lib,
  config,
  flakeRoot,
  ...
}: {
  config = lib.mkIf ("kitty" == config.terminal) {
    xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/kitty";
  };
}
