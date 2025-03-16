USER_NIX_ROOT=$HOME/.nix
# ------------------------------------------------------------
# INFO: Enable completion init
# ------------------------------------------------------------
autoload -Uz compinit && compinit
# ------------------------------------------------------------
# INFO: source plugins
# ------------------------------------------------------------
source $USER_NIX_ROOT/shell/plugins.zsh
