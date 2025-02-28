{ pkgs, lib, config, flakeRoot, ... }:
{
  home.packages = with pkgs;
    [
      git
    ];

  xdg.configFile."git".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/git";
}
