{ pkgs, lib, config, flakeRoot, ... }:
{
  imports = [
    (import ./zsh.nix { inherit pkgs lib config flakeRoot; })
    (import ./bash.nix { inherit pkgs lib config flakeRoot; })
  ];

  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/starship.toml";
}
