{ lib, pkgs, stateVersion, username, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  # Let home-manager manage itself
  programs.home-manager.enable = true;
  home = {
    inherit stateVersion;
    inherit username;
    homeDirectory =
      if isDarwin then
        "/Users/${username}"
      else
        "/home/${username}";


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
