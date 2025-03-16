{ pkgs, lib, config, flakeRoot, ... }:
let
  cfg = config.shell.zsh;
  separator = ''# ------------------------------------------------------------
  '';
in
{
  options.shell.zsh.enable = lib.mkEnableOption "Use zsh";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
    [
        # zsh-syntax-highlighting
        # zsh-completions
        # zsh-autosuggestions
    ];

    programs = {
      zsh.enable = true;
      starship.enableZshIntegration = true;
    };

    home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.zshrc";
    home.file.".alias.zsh".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.alias.zsh";

    # # aliases
    # home.file.".nix/shell/alias.zsh".source = ./alias.zsh;
    # # plugins
    # home.file.".nix/shell/plugins.zsh".text = with pkgs;
    # ''
    # export FZF\_DEFAULT\_OPTS='--bind=shift-tab:up,tab:down'
    # source ${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
    # '' + separator + ''
    # fpath=(${zsh-completions}/share/zsh/site-functions $fpath)
    # '' + separator +
    # builtins.readFile ./plugins/sudo.zsh
    # + separator + ''
    # source ${zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # '';
  };
}
