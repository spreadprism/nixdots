{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.development.gcp.enable;
in {
  options.development.gcp.enable = lib.mkEnableOption "Add GCP support";

  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      # INFO: gcloud
      (google-cloud-sdk.withExtraComponents (with google-cloud-sdk.components; [
        # INFO: Plugins
        cloud-sql-proxy
        cloud-run-proxy
        gke-gcloud-auth-plugin
        package-go-module
      ]))
      fzf
      (writeShellScriptBin "gcx" (builtins.readFile ./gcx))
    ];
    shell.aliases = {
      gc = "gcloud";
    };
  };
}
