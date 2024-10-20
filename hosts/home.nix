{ inputs, lib, outputs, pkgs, stateVersion, username, system, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  home = {
    inherit stateVersion;
    inherit username;
    homeDirectory =
      if isDarwin then
        "/Users/${username}"
      else
        "/home/${username}";

    nixpkgs = {
      config.allowUnfree = true;
    };

    nix = {
      package = pkgs.nixVersions.latest;
      settings = {
        experimental-features = "flakes nix-command";
        trusted-users = [
          "root"
          "${username}"
        ];
      };
    };

    packages = with pkgs;
    [

    ]
    ++ lib.optionals isLinux [

    ]
    ++ lib.optionals isDarwin [

    ];

    programs = {

    };
  };
}
