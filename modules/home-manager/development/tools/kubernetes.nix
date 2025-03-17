{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.development.enable {
    home.packages = with pkgs; [
      kubectl
      kubectx
      kubernetes-helm
      minikube
    ];
    shell.aliases = {
      kc = "kubectx";
      kcu = "kc -u";
      kn = "kubens";
      knu = "k config set-context --current --namespace=";
      k = "kubectl";
      ku = "knu && kcu";
    };
  };
}
