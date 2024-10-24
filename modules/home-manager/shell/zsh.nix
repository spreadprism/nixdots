{ pkgs, lib, config, flakeRoot, ... }:
let
  cfg = config.shell.zsh;
in
{
  options.shell.zsh.enable = lib.mkEnableOption "Use zsh";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
    [
        ripgrep
        fzf
        jq
        jqp
        bat
        eza
        zoxide
        direnv
    ];

    programs = {
      zsh.enable = true;
      starship.enableZshIntegration = true;
    };

    home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.zshrc";
  };
}
