{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.development.enable {
    home.packages = with pkgs; [
      terraform
    ];
    shell.aliases = {
      tf = "terraform";
    };
  };
}
