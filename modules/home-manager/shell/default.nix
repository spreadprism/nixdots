{ pkgs, lib, config, flakeRoot, username, ... }:
let
  args = { inherit pkgs lib config flakeRoot username; };
in
{
  imports = [
      (import ./zsh.nix args)
      (import ./bash.nix args)
  ];

  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/starship.toml";
}
