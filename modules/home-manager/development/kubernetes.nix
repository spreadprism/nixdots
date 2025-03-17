{
  pkgs,
  config,
  lib,
  ...
}: let
  devEnabled = config.development.enable;
in {
  config = lib.mkIf devEnabled {
    home.packages = with pkgs; [
      kubectl
      kubectx
      kubernetes-helm
      minikube
    ];
    home.file.".nix/shell/kubernetes.sh".text = ''
      alias kc='kubectx'
      alias kcu='kc -u'
      alias kn='kubens'
      alias knu='k config set-context --current --namespace='
      alias k='kubectl'
      alias ku='knu && kcu'
    '';
  };
}
