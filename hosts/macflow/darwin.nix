{pkgs, ...}: {
  ids.gids.nixbld = 350;
  environment.systemPackages = with pkgs; [
    nodejs_22
  ];
  nix.settings.trusted-users = ["eduguay"];

  homebrew = {
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "ansible"
      "devstack"
      "efctl"
      "protobuf"
      {
        name = "mysql@8.0";
        link = true;
        restart_service = true;
        conflicts_with = ["mysql"];
      }
    ];
    casks = [
      "slack"
      "zoom"
      "obsidian"
      "yt-music"
      "podman-desktop"
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
