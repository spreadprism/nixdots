{
  lib,
  config,
  flakeRoot,
  ...
}: {
  config = lib.mkIf ("ghostty" == config.terminal) {
    xdg.configFile."ghostty/config".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/ghostty/config";
  };
}
