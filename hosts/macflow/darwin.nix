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

<<<<<<< HEAD
  fonts.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
=======
  terminal.kitty.enable = true;
>>>>>>> 288a1c8 (added kitty module)
}
