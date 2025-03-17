{
  pkgs,
  config,
  flakeRoot,
  ...
}: {
  home.packages = with pkgs; [
    tmux
  ];
  xdg.configFile.tmux.source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/tmux";
  programs.zsh.zplug = {
    plugins = [
      {
        name = "${./tmux.zsh}";
        tags = ["from::local"];
      }
    ];
  };
}
