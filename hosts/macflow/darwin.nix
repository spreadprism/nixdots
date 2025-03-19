{pkgs, ...}: {
  ids.gids.nixbld = 350;
  environment.systemPackages = with pkgs; [
    nodejs_22
    protobuf
  ];

  # TODO: Moves things to general darwin.nix
  homebrew = {
    brews = [
      "docker"
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
