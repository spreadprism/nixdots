{pkgs, ...}: {
  targets.genericLinux.enable = true;
  home = {
    packages = with pkgs; [
    ];
  };

  shell.supported = ["zsh"];
  desktop = "hyprland";
  terminal = ["ghostty"];
  development.enable = true;

  python = true;
  go = true;
  rust = true;

  # # INFO: enable development features (Lsp, dap, linters)
  # development.enable = true;
  # # INFO: Languages
  # development.python.enable = true;
  # development.go.enable = true;
  # development.rust.enable = true;
  # # INFO: Desktop configs
  # terminal.ghostty = {
  #   enable = true;
  #   install = false;
  # };
}
