{config, ...}: {
  programs.dircolors = {
    enable = true;
    enableZshIntegration = builtins.elem "zsh" config.shell.supported;
    enableBashIntegration = builtins.elem "bash" config.shell.supported;
  };
}
