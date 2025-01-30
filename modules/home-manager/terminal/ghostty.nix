{ pkgs, lib, config, flakeRoot, ... }:
let
  cfg = config.terminal.ghostty;
in
{
  options.terminal.ghostty = {
    enable = lib.mkEnableOption "use ghostty terminal";
    install = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
    if cfg.install then [
        ghostty
    ] else [];
    xdg.configFile."ghostty/config".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/ghostty/config";
  };
}
