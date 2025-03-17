{
  outputs,
  lib,
  pkgs,
  stateVersion,
  username,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
  homeDirectory =
    if isDarwin
    then "/Users/${username}"
    else "/home/${username}";
in {
  imports = [
    outputs.homeManagerModules
  ];
  config = {
    nixpkgs.overlays = [
      outputs.overlays.stable-packages
    ];
    nix = {
      package = pkgs.nix;
      settings.experimental-features = ["nix-command" "flakes"];
    };
    home = {
      inherit stateVersion;
      inherit username;
      inherit homeDirectory;
      packages = with pkgs;
        [
          nh
        ]
        ++ lib.optionals isLinux [
        ]
        ++ lib.optionals isDarwin [
        ];
    };
    programs.home-manager.enable = true;
  };
}
