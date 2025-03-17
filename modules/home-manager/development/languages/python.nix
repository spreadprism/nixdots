{
  pkgs,
  lib,
  config,
  flakeRoot,
  ...
}: let
  cfg = config.development.python;
  devEnabled = config.development.enable;
in {
  options.development.python.enable = lib.mkEnableOption "Add python development support";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        micromamba
        pipx
        poetry
      ]
      ++ lib.optionals devEnabled [
        python312Packages.debugpy
        ruff
        ruff-lsp
        basedpyright
      ];

    home.file.".mambarc".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.mambarc";

    home.file.".nix/shell/python.sh".text =
      # INFO: micromamba
      ''
        export MAMBA_ROOT_PREFIX=~/.micromamba
        alias mamba=micromamba
        eval "$(micromamba shell hook --shell zsh)"
      ''
      + # INFO: pipx
      ''
        export PATH="$PATH:$HOME/.local/bin"
      '';
  };
}
