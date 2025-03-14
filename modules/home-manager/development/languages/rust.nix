{ pkgs, lib, config, ... }:
let
  cfg = config.development.rust;
  codelldb = pkgs.vscode-extensions.vadimcn.vscode-lldb;
in
{
  options.development.rust.enable = lib.mkEnableOption "Add rust development support";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        cargo
        rustc
      ] ++ lib.optionals config.development.enable [
        rustfmt
        codelldb
      ];
    home.file.".nix/shell/rust.sh".text =
    ''
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="${codelldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter:$PATH"
    '';
  };
}
