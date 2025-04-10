{
  config,
  flakeRoot,
  ...
}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = builtins.elem "zsh" config.shell.supported;
    enableBashIntegration = builtins.elem "bash" config.shell.supported;
  };
  shell.aliases.cdw = "cd $(dirname \"$DIRENV_FILE\")";
  xdg.configFile."direnv/direnv.toml".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/direnv/direnv.toml";
}
