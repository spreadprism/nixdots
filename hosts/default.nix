{ inputs, outputs, stateVersion, utils, ... }:
let
  all_paths = builtins.readDir ./. ;
  all_dirs = builtins.filter (key: all_paths.${key} == "directory") (builtins.attrNames all_paths);

  nixos_hosts = builtins.filter (host: builtins.pathExists ./${host}/configuration.nix) all_dirs;
  macos_hosts = builtins.filter (host: builtins.pathExists ./${host}/darwin.nix) all_dirs;

  hardware_hosts = nixos_hosts ++ macos_hosts;
  other_hosts = builtins.filter (host: builtins.pathExists ./${host}/home.nix && !builtins.elem host hardware_hosts) all_dirs;
in
{
  homeConfigurations = builtins.listToAttrs (map (path: { name = "avalon@archxps"; value = utils.mkHome (builtins.baseNameOf path); }) other_hosts);
  # homeConfigurations = {};
  # TODO: Add nixos configurations
  nixosConfigurations = {};
  darwinConfigurations = {};
}
