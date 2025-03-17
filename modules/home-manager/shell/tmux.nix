{
  pkgs,
  lib,
  config,
  flakeRoot,
  ...
}: {
  home.packages = with pkgs; [
    tmux
  ];

  xdg.configFile.tmux.source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/tmux";
}
