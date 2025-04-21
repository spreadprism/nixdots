{
  pkgs,
  lib,
  config,
  ...
}: let
  readNix = path: builtins.filter (x: lib.hasSuffix ".nix" x) (lib.filesystem.listFilesRecursive path);
in {
  imports = (readNix ./languages) ++ (readNix ./lsp) ++ (readNix ./tools);
  config.home.packages = lib.optionals config.development.enable (with pkgs; [
    curl
    grpcurl
  ]);
  options = {
    development.enable = lib.mkEnableOption "Enable development features";
  };
}
