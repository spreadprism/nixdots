{
  config,
  flakeRoot,
  ...
}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = builtins.elem "zsh" config.shell.supported;
    enableBashIntegration = builtins.elem "bash" config.shell.supported;
  };
  xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/starship.toml";
}
