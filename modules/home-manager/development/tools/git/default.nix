{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs;
    [
      git
      gh
    ]
    ++ lib.optionals config.development.enable [
      gitleaks
    ];

  xdg.configFile = {
    "git/config".source = ./config;
    "git/.gitignore".source = ./.gitignore;
  };
}
