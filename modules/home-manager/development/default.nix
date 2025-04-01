{
  inputs,
  lib,
  ...
}: let
  read = lib.filesystem.listFilesRecursive;
in {
  imports = (read ./languages) ++ (read ./lsp) ++ (read ./tools);
  options = {
    development.enable = lib.mkEnableOption "Enable development features";
  };
}
