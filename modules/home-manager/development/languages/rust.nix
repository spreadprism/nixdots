{
  pkgs,
  lib,
  config,
  ...
}:{
  options.rust.enable = lib.mkEnableOption "add rust support";
  config = lib.mkIf config.rust.enable {
    home.packages = with pkgs;
      [
        cargo
        rustc
      ]
      ++ lib.optionals config.development.enable [
        rustfmt
      ];
    development.lsp.codelldb.enable = config.development.enable;
    shell.paths = [
      "$HOME/.cargo/bin"
    ];
  };
}
