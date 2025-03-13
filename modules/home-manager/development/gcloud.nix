{ pkgs, config, lib, ... }:
let
  cfg = config.development.gcp.enable;
  gdk = pkgs.google-cloud-sdk.withExtraComponents( with pkgs.google-cloud-sdk.components; [
    bq
    gsutil
    cloud-sql-proxy
    cloud-run-proxy
    gke-gcloud-auth-plugin
  ]);
in
  {
  options.development.gcp.enable = lib.mkEnableOption "Add GCP support";

  config = lib.mkIf cfg {
    home.packages = with pkgs;
      [
        gdk
      ];
    home.file.".nix/shell/gcloud.sh".text =
      ''
      '';
  };
}
