{ lib, pkgs, stateVersion, username, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
  homeDirectory = if isDarwin
    then "/Users/${username}"
    else "/home/${username}";
  flakeRoot = "${homeDirectory}/nix";
in
{
  # INFO: Let home-manager manage itself
  programs.home-manager.enable = true;
  # INFO: Enable flakes
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  home = {
    inherit stateVersion;
    inherit username;
    inherit homeDirectory;


    packages = with pkgs;
    [
        git
    ]
    ++ lib.optionals isLinux [

    ]
    ++ lib.optionals isDarwin [

    ];
  };

  imports = [
    ../modules/shell
  ];

  shell.zsh.enable = true;
}
