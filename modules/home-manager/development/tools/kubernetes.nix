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
      minikube
      kind
      helmfile
      kustomize
      (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-secrets
          helm-diff
          helm-git
        ];
      })
    ];
    shell = {
      extra = [
        "export KUBECONFIG=$HOME/.kube/config"
        "source <(kind completion zsh)"
      ];
      aliases = {
        k = "kubectl";
        h = "helm";
        hf = "helmfile";
        kc = "kubectx";
        kcu = "kc -u";
        kn = "kubens";
        knu = "k config set-context --current --namespace=";
        ku = "knu && kcu";
      };
    };
  };
}
