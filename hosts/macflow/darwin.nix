{ lib, pkgs, stateVersion, username, hostname, ... }:
{
  environment.systemPackages = with pkgs;
  [
  ];

  homebrew = {
    brews = [

    ];

    casks = [

    ];

    masApps = {

    };
  };

  fonts.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  terminal.kitty.enable = true;
}
