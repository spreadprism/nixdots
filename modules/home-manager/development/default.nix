{
  pkgs,
  lib,
  ...
}: let
  readNix = path: builtins.filter (x: lib.hasSuffix ".nix" x) (lib.filesystem.listFilesRecursive path);
in {
  imports = (readNix ./languages) ++ (readNix ./lsp) ++ (readNix ./tools);
  config.home.packages = with pkgs; [
    grpcurl
  ];
  options = {
    development.enable = lib.mkEnableOption "Enable development features";
  };
}
