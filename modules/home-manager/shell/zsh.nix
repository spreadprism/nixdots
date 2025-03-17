{ pkgs, lib, flakeRoot, config, ... }:
let
  cfg = config.shell.zsh;
in
{
  options.shell.zsh.enable = lib.mkEnableOption "Use zsh";

  config = lib.mkIf cfg.enable {
    home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.zshrc";
    home.file.".alias.zsh".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.alias.zsh";
    home.packages = with pkgs; [

    ];
    programs = {
    #   zsh = {
    #     enable = true;
    #     enableCompletion = true;
    #     syntaxHighlighting.enable = true;
    #     autosuggestion = {
    #       enable = true;
    #       strategy = [
    #         "match_prev_cmd"
    #         "completion"
    #       ];
    #     };
    #     sessionVariables = {
    #       FZF_DEFAULT_OPTS = "--bind=shift-tab:up,tab:down";
    #     };
    #     envExtra = lib.concatLines [''
    #       if command -v dircolors &> /dev/null
    #       then
    #         eval "$(dircolors -b)" # Enables LS_COLORS
    #       fi''
    #       "zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'"
    #       "zstyle ':completion:*' list-colors '\${(s.:.)LS_COLORS}'"
    #       "zstyle ':completion:*' menu no"
    #       "zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'"
    #       "zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'"
    #     ];
    #     zplug = {
    #       enable = true;
    #       plugins = [
    #         { name = "zsh-users/zsh-syntax-highlighting"; }
    #         { name = "zsh-users/zsh-completions"; }
    #         { name = "zsh-users/zsh-autosuggestions"; }
    #         # INFO: fzf
    #         { name = "joshskidmore/zsh-fzf-history-search"; }
    #         { name = "Aloxaf/fzf-tab"; }
    #         # INFO: OMZ::plugins
    #         { name = "plugins/sudo"; tags = [ "from::oh-my-zsh"]; }
    #         { name = "plugins/dirhistory"; tags = [ "from::oh-my-zsh"]; }
    #       ];
    #     };
    #   };
    #   starship.enableZshIntegration = true;
    #   direnv.enableZshIntegration = true;
    #   dircolors.enableZshIntegration = true;
    };
  };
}
