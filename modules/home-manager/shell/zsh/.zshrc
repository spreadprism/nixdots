USER_NIX_ROOT=$HOME/.nix
# ------------------------------------------------------------
# INFO: source plugins
# ------------------------------------------------------------
source $USER_NIX_ROOT/shell/plugins.zsh
# ------------------------------------------------------------
# INFO: Load aliases
# ------------------------------------------------------------
source $USER_NIX_ROOT/shell/alias.zsh
# ------------------------------------------------------------
# INFO: source completion
# ------------------------------------------------------------
autoload -Uz compinit && compinit
source $USER_NIX_ROOT/shell/completion.zsh
if command -v dircolors &> /dev/null
then
  eval "$(dircolors -b)" # Enables LS_COLORS
fi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# ------------------------------------------------------------
# INFO: Command history
# ------------------------------------------------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
# ------------------------------------------------------------
# INFO: Initialize hooks
# ------------------------------------------------------------
source $USER_NIX_ROOT/shell/init.zsh
