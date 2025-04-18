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
      "devstack"
      "efctl"
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
    taps = [
      {
        name = "everflow-io/homebrew-everflow";
        clone_target = "git@github.com:everflow-io/homebrew-everflow.git";
      }
    ];
  };
}
