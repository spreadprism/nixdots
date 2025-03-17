{
  pkgs,
  lib,
  config,
  ...
}: let
  codelldb = pkgs.vscode-extensions.vadimcn.vscode-lldb;
in {
  options.development.lsp.codelldb.enable = lib.mkEnableOption "Enable codelldb";
  config = lib.mkIf config.development.lsp.codelldb.enable {
    home.packages = with pkgs; [
      codelldb
    ];
    shell.paths = [
      "${codelldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter:$PATH"
    ];
  };
}
