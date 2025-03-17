{pkgs, ...}: {
  targets.genericLinux.enable = true;
  home = {
    packages = with pkgs; [
    ];
  };

  # INFO: shell
  shell.zsh.enable = true;
  # INFO: enable development features (Lsp, dap, linters)
  development.enable = true;
  # INFO: Languages
  development.python.enable = true;
  development.go.enable = true;
  development.rust.enable = true;
  # INFO: Desktop configs
  desktop.enable = true;
  terminal.ghostty = {
    enable = true;
    install = false;
  };
}
