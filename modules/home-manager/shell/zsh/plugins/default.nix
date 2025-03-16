{ pkgs, lib, config, flakeRoot, ... }:
let
  separator = ''# ------------------------------------------------------------
  '';
in
{
  home.file.".nix/shell/plugins.zsh".text = with pkgs;
  ''
  export FZF\_DEFAULT\_OPTS='--bind=shift-tab:up,tab:down'
  source ${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
  '' + separator + ''
  fpath=(${zsh-completions}/share/zsh/site-functions $fpath)
  '' + separator +
  builtins.readFile ./sudo.zsh
  + separator + ''
  source ${zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  '';
}
