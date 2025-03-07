{ lib, pkgs, stateVersion, config, username, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
  homeDirectory = if isDarwin
    then "/Users/${username}"
    else "/home/${username}";
in
{
  # INFO: Let home-manager manage itself
  programs.home-manager.enable = true;
  # INFO: Enable flakes
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  home = {
    inherit stateVersion;
    inherit username;
    inherit homeDirectory;
    packages = with pkgs;
    [
        git
        gh
        ripgrep
        nh
    ]
    ++ lib.optionals isLinux [

    ]
    ++ lib.optionals isDarwin [

    ];
  };
}
