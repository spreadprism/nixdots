{
  nixpkgs,
  inputs,
  hostname,
  defaultSystem,
  extraArgs,
  extraModules,
  ...
}: let
  hostCfg =
    if builtins.pathExists ../../hosts/${hostname}
    then import ../../hosts/${hostname} {}
    else {};
  getOrDefault = key: default:
    if builtins.hasAttr key hostCfg
    then builtins.getAttr key hostCfg
    else default;
  system = getOrDefault "system" "x86_64-linux";
  username = getOrDefault "username" "avalon";

  modules = [../defaults/home.nix ../../hosts/${hostname}/home.nix] // extraModules;
  extraSpecialArgs =
    {
      home-manager = true;
      inherit username system hostname;
    }
    // extraArgs;
in {
  name = "${username}@${hostname}";
  value = inputs.home-manager.lib.homeManagerConfiguration {
    inherit modules;
    inherit extraSpecialArgs;
    pkgs = nixpkgs.legacyPackages.${system};
  };
}
