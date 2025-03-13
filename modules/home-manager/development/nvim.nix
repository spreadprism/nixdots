{ pkgs, lib, config, flakeRoot, ... }:
let
  devEnabled = config.development.enable;
in
{
  config = lib.mkIf devEnabled {
    home.packages = with pkgs;
      [
        neovim
        figlet
        lolcat
        lua51Packages.luarocks
      ];

    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/nvim";
    xdg.configFile."figlet/ANSI_Shadow.flf".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/figlet/ANSI Shadow.flf";

  home.file.".nix/shell/mason.sh".text = ''export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"'';
  home.file.".nix/shell/nvim.sh".text = ''export NVIM_LISTEN_ADDRESS=/tmp/nvim.socket'';
  };
}
