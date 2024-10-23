{ pkgs, lib, config, flakeRoot, ... }:
{
  home.packages = with pkgs;
  [
      neovim
      figlet
      lolcat
  ];

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/nvim";
}
