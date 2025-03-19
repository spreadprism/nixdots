{
  inputs,
  outputs,
  stateVersion,
  ...
}: let
  all_paths = builtins.readDir ./.;
  all_dirs = builtins.filter (key: all_paths.${key} == "directory") (builtins.attrNames all_paths);

  nixos_hosts = builtins.filter (host: builtins.pathExists ./${host}/configuration.nix) all_dirs;
  macos_hosts = builtins.filter (host: builtins.pathExists ./${host}/darwin.nix) all_dirs;
  home_hosts = builtins.filter (host: builtins.pathExists ./${host}/home.nix && !builtins.elem host (nixos_hosts ++ macos_hosts)) all_dirs;

  args = {inherit inputs outputs stateVersion;};
  inherit
    (import ../nix/mkHosts {
      inherit inputs outputs;
      extraArgs = args;
    })
    mkHome
    mkDarwin
    ;
in {
  homeConfigurations = builtins.listToAttrs (map (host_path: mkHome (builtins.baseNameOf host_path)) home_hosts);
  # nixosConfigurations = builtins.listToAttrs (map (host_path: mkNixOS (builtins.baseNameOf host_path) default_username) nixos_hosts);
  darwinConfigurations = builtins.listToAttrs (map (host_path: mkDarwin (builtins.baseNameOf host_path)) macos_hosts);
}
