{ pkgs, lib, config, flakeRoot, ... }:
{
  home.packages = with pkgs;
    [
      conda
    ];

    home.file.".condarc".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.condarc";
}
