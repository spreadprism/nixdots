{ lib, pkgs, stateVersion, username, hostname, ... }:
{
  ids.gids.nixbld = 350;
  environment.systemPackages = with pkgs;
  [
      nodejs_22
      protobuf
  ];

  # TODO: Moves things to general darwin.nix
  homebrew = {
    brews = [
      "docker"
      # {
      #   name = "redis";
      #   start_service = true;
      # }
      # {
      #   name = "mysql@8.0";
      #   start_service = true;
      #   link = true;
      # }
      # {
      #   name = "dotnet@8";
      #   link = true;
      # }
    ];
    casks = [
      "slack"
      "zoom"
      "obsidian"
      "1password"
      "1password-cli"
      "yt-music"
    ];
    masApps = {

    };
  };
}
