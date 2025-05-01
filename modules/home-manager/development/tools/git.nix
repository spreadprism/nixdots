{
  pkgs,
  config,
  lib,
  flakeRoot,
  ...
}: {
  home.packages = with pkgs;
    [
      git
      gh
    ]
    ++ lib.optionals config.development.enable [
      gitleaks
      act
    ];

  xdg.configFile."git".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/git";
}
