{ inputs, outputs, stateVersion, username, ... }:
let
  all_paths = builtins.readDir ./. ;
  all_dirs = builtins.filter (key: all_paths.${key} == "directory") (builtins.attrNames all_paths);

  nixos_hosts = builtins.filter (host: builtins.pathExists ./${host}/configuration.nix) all_dirs;
  macos_hosts = builtins.filter (host: builtins.pathExists ./${host}/darwin.nix) all_dirs;
  home_only_hosts = builtins.filter (host: builtins.pathExists ./${host}/home.nix && !builtins.elem host (nixos_hosts ++ macos_hosts)) all_dirs;

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
          ../modules/home-manager
          ./home-manager.nix
          ./home.nix
          ./${hostname}/home.nix
        ];
      };
  };
  mkNixOS = hostname: default_username:
    let
      host_conf = import ../hosts/${hostname} args;
      system = if builtins.hasAttr "system" host_conf
        then host_conf.system
        else "x86_64-linux";
      username = if builtins.hasAttr "username" host_conf
        then host_conf.username
        else default_username;
      specialArgs = args // { inherit username system hostname; };
    in
    {
      name = hostname;
      value = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = [
          ./configuration.nix
          ./${hostname}/configuration.nix
          ../modules/shared
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.${username} = {
              imports = [
                ./home.nix
                ../modules/home-manager
              ] ++ inputs.nixpkgs.lib.optionals (builtins.pathExists ./${hostname}/home.nix) [
                  ./${hostname}/home.nix
                ];
            };
          }
        ];
      };
    };
  mkMacOS = hostname: default_username:
  let
    host_conf = import ../hosts/${hostname} args;
    system = if builtins.hasAttr "system" host_conf
      then host_conf.system
      else "aarch64-darwin";
    username = if builtins.hasAttr "username" host_conf
      then host_conf.username
      else default_username;
    specialArgs = args // { inherit username system hostname; };
  in
  {
      name = hostname;
      value = inputs.nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        inherit system;
        modules = [
          ./darwin.nix
          ./${hostname}/darwin.nix
          ../modules/shared
          inputs.nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = system == "aarch64-darwin";
              user = username;
            };
          }
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.${username} = {
              imports = [
                ./home.nix
                ./${hostname}/home.nix
                ../modules/home-manager
              ];
            };
          }
        ];
      };

  };
in
{
  homeConfigurations = builtins.listToAttrs (map (host_path: mkHome (builtins.baseNameOf host_path) default_username) home_only_hosts);
  nixosConfigurations = builtins.listToAttrs (map (host_path: mkNixOS (builtins.baseNameOf host_path) default_username) nixos_hosts);
  darwinConfigurations = builtins.listToAttrs (map (host_path: mkMacOS (builtins.baseNameOf host_path) default_username) macos_hosts);
}
