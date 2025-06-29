{
  outputs,
  lib,
  pkgs,
  inputs,
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
    nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        outputs.overlays.stable-packages
        outputs.overlays.codelldb
        outputs.overlays.additions
        inputs.nh.overlays.default
      ];
    };
    shell.aliases = {
      sctl = lib.mkIf isLinux "systemctl";
      sv = lib.mkIf isLinux "sudoedit";
    };
    home = {
      inherit stateVersion;
      inherit username;
      inherit homeDirectory;
      packages = with pkgs;
        [
          nh
          sops
          nixdots
        ]
        ++ lib.optionals isLinux [
        ]
        ++ lib.optionals isDarwin [
        ];
    };
    programs.home-manager.enable = true;
  };
}
