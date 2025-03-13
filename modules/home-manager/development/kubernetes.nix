{ pkgs, config, lib, ... }:
let
  dev_enabled = config.development.enable;
in
{
  config = lib.mkIf dev_enabled {
    home.packages = with pkgs;
      [
        kubectx
      ];
    home.file.".nix/shell/kubernetes.sh".text =
    ''
    alias kc='kubectx'
    alias kcu='kc -u'
    alias kn='kubens'
    alias knu='k config set-context --current --namespace='
    alias k='kubectl'
    alias ku='knu && kcu'
    '';
  };
}
