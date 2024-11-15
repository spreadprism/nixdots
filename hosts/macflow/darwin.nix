{ lib, pkgs, stateVersion, username, hostname, ... }:
{
  environment.systemPackages = with pkgs;
  [
      nodejs_22
      dotnet-sdk_8
  ];

  # TODO: Moves things to general darwin.nix
  homebrew = {
    brews = [
      "pipx"
      "nginx" # INFO: Remember to add brew services start nginx
      "redis" # INFO: Remember to add brew services start redis
      "mysql@8.0"
      "protobuf"
      "bazelisk"
      "minikube"
      "helm"
    ];

    # INFO: brew services start ${SERVICE}


    casks = [
      "slack"
      "zoom"
      "obsidian"
      "1password"
      "yt-music"
      "microsoft-outlook"
    ];


    masApps = {

    };
  };

  fonts.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
