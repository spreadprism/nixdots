{
  pkgs,
  lib,
  ...
}: let
  read = lib.filesystem.listFilesRecursive;
in {
  imports = (read ./languages) ++ (read ./lsp) ++ (read ./tools);
  config.home.packages = with pkgs; [
    grpcurl
  ];
  options = {
    development.enable = lib.mkEnableOption "Enable development features";
  };
}
