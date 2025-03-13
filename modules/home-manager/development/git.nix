{ pkgs, config, lib, flakeRoot, ... }:
let
  devEnabled = config.development.enable;
in
{
  home.packages = with pkgs;
    [
      git
    ] ++ lib.optionals devEnabled [
      lazygit
      gitleaks
    ];

  xdg.configFile."git".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/git";
}
