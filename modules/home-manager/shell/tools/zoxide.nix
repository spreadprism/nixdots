{config, ...}: {
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
    enableZshIntegration = builtins.elem "zsh" config.shell.supported;
    enableBashIntegration = builtins.elem "bash" config.shell.supported;
  };
}
