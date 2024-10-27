{ pkgs, lib, config, flakeRoot, ... }:
let
  cfg = config.shell.zsh;
in
{
  options.terminal.kitty.enable = lib.mkEnableOption "use kitty terminal";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
    [
        kitty
    ];

    home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.zshrc";
  };
}
