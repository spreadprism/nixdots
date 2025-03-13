{ pkgs, config, flakeRoot, ... }:
{
  home.packages = with pkgs;
    [
      git
      lazygit
    ];

  xdg.configFile."git".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/git";
}
