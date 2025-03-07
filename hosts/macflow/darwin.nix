{ lib, pkgs, stateVersion, username, hostname, ... }:
{
  ids.gids.nixbld = 350;
  environment.systemPackages = with pkgs;
  [
      nodejs_22
      podman
      podman-compose
  ];

  # TODO: Moves things to general darwin.nix
  homebrew = {
    brews = [
      "go"
      "pipx"
      "docker"
      # { # BUG: This always fails to start
      #   name = "nginx";
      #   start_service = true;
      # }
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
      "1password-cli"
      "yt-music"
      "microsoft-outlook"
      "podman-desktop"
    ];


    masApps = {

    };
  };
}
