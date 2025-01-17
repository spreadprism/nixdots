{ lib, pkgs, stateVersion, username, hostname, ... }:
{
  environment.systemPackages = with pkgs;
  [
      nodejs_22
  ];

  # TODO: Moves things to general darwin.nix
  homebrew = {
    brews = [
      "pipx"
      "nginx"
      "podman"
      "podman-compose"
      {
        name = "redis";
        start_service = true;
      }
      {
        name = "mysql@8.0";
        start_service = true;
        link = true;
      }
      {
        name = "dotnet@8";
        link = true;
      }
      "protobuf"
      "bazelisk"
      "minikube"
      "helm"
    ];

    casks = [
      "slack"
      "zoom"
      "obsidian"
      "1password"
      "yt-music"
      "microsoft-outlook"
      "podman-desktop"
    ];


    masApps = {

    };
  };

  fonts.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
