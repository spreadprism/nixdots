{
  pkgs,
  lib,
  config,
  flakeRoot,
  ...
}: {
  options.python.enable = lib.mkEnableOption "Add python support";

  config = lib.mkIf config.python.enable {
    home.packages = with pkgs;
      [
        micromamba
        pipx
        poetry
      ]
      ++ lib.optionals config.development.enable [
        python312Packages.debugpy
        ruff
        ruff-lsp
        basedpyright
      ];

    home.file.".mambarc".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.mambarc";
    shell = {
      aliases = {
        mamba = "micromamba";
      };
      paths = [
        "$HOME/.local/bin"
      ];
    };

    # home.file.".nix/shell/python.sh".text =
    #   # INFO: micromamba
    #   ''
    #     export MAMBA_ROOT_PREFIX=~/.micromamba
    #     alias mamba=micromamba
    #     eval "$(micromamba shell hook --shell zsh)"
    #   ''
    #   + # INFO: pipx
    #   ''
    #     export PATH="$PATH:$HOME/.local/bin"
    #   '';
  };
}
