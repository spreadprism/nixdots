{
  inputs,
  outputs,
  extraArgs,
  ...
}: let
  inherit (inputs) nixpkgs;
in {
  mkHome = hostname: let
    hostCfg =
      if builtins.pathExists ../../hosts/${hostname}/default.nix
      then import ../../hosts/${hostname} {}
      else {};
    getOrDefault = key: default:
      if builtins.hasAttr key hostCfg
      then builtins.getAttr key hostCfg
      else default;

    system = getOrDefault "system" "x86_64-linux";
    username = getOrDefault "username" "avalon";

    modules = [
      ../defaults/home.nix
      ../../hosts/${hostname}/home.nix
    ];
    pkgs = nixpkgs.legacyPackages.${system}.extend inputs.nh.overlays.default;
    inherit (pkgs.stdenv) isDarwin;
    homeDirectory =
      if isDarwin
      then "/Users/${username}"
      else "/home/${username}";
    flakeRoot = "${homeDirectory}/nixdots";
    extraSpecialArgs =
      {
        inherit username system hostname flakeRoot;
      }
      // extraArgs;
  in {
    name = "${username}@${hostname}";
    value = inputs.home-manager.lib.homeManagerConfiguration {
      inherit modules;
      inherit extraSpecialArgs;
      inherit pkgs;
    };
  };
}
