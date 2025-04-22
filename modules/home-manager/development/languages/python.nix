{
  pkgs,
  lib,
  config,
  flakeRoot,
  ...
}: {
  options.python.enable = lib.mkEnableOption "Add python support";

  config = lib.mkIf config.python.enable {
    home.packages = with pkgs; [
      pipx
      micromamba
      uv
    ];

    home.file.".mambarc".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.mambarc";
    shell = {
      aliases = {
        mamba = "micromamba";
      };
      paths = [
        "$HOME/.local/bin"
      ];
      envs = {
        MAMBA_ROOT_PREFIX = "$HOME/.micromamba";
      };
      extra = [
        ''eval "$(micromamba shell hook --shell zsh)"''
      ];
    };
  };
}
