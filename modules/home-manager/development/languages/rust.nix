{
  pkgs,
  lib,
  config,
  ...
}: {
  options.rust.enable = lib.mkEnableOption "add rust support";
  config = lib.mkIf config.rust.enable {
    home.packages = with pkgs;
      [
        cargo
        rustc
      ]
      ++ lib.optionals config.development.enable [
        codelldb
        rustfmt
        rust-analyzer
      ];
    shell.paths = [
      "$HOME/.cargo/bin"
    ];
  };
}
