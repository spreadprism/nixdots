{ inputs, outputs, stateVersion, username, ... }:
let
  all_paths = builtins.readDir ./. ;
  all_dirs = builtins.filter (key: all_paths.${key} == "directory") (builtins.attrNames all_paths);

  nixos_hosts = builtins.filter (host: builtins.pathExists ./${host}/configuration.nix) all_dirs;
  macos_hosts = builtins.filter (host: builtins.pathExists ./${host}/darwin.nix) all_dirs;

  all_hosts = nixos_hosts ++ macos_hosts;
  home_hosts = builtins.filter (host: builtins.pathExists ./${host}/home.nix && !builtins.elem host all_hosts) all_dirs;

  default_username = username;
  args = { inherit inputs outputs stateVersion; };
  mkHome = hostname: default_username:
    let host_conf = import ../hosts/${hostname} args;
    system = if builtins.hasAttr "system" host_conf
      then host_conf.system
      else "x86_64-linux";
    username = if builtins.hasAttr "username" host_conf
      then host_conf.username
      else default_username;
    specialArgs = args // { inherit username system hostname; };
  in
  {
      name = "${username}@${hostname}";
      value = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        extraSpecialArgs = specialArgs;
        modules = [
          ./home.nix
          ./${hostname}/home.nix
        ];
      };
  };
in
{
  homeConfigurations = builtins.listToAttrs (map (host_path: mkHome (builtins.baseNameOf host_path) default_username) home_hosts);
  # TODO: Add nixos_hosts logic
  nixosConfigurations = {};
  # TODO: Add macos_hosts logic
  darwinConfigurations = {};
}
