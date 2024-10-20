{ inputs, outputs, stateVersion, ... }:
{
  # INFO: Supported systems
  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
  mkHome = hostname:
    let
      conf = import ../hosts/${hostname} { inherit inputs outputs stateVersion; };
      platform = if builtins.hasAttr "platform" conf
        then conf.platform
        else "x86_64-linux";

      username = if builtins.hasAttr "username" conf
        then conf.username
        # TODO: Better way than hardcoding username multiple mk
        else "avalon";
      system = platform;
    in
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${platform};
        extraSpecialArgs = {
          inherit
          inputs
          outputs
          stateVersion
          username
          system
          platform
          hostname;
        };
        modules = [
          ../hosts/home.nix
          ../hosts/${hostname}/home.nix
        ];
      };
  mkDarwin = hostname:
    let
      conf = import ../hosts/${hostname} { inherit inputs outputs stateVersion; };
      platform = if builtins.hasAttr "platform" conf
        then conf.platform
        else "aarch64-darwin";

      username = if builtins.hasAttr "username" conf
        then conf.username
        # TODO: Better way than hardcoding username multiple mk
        else "avalon";

      specialArgs = { inherit inputs outputs stateVersion username platform hostname; };
    in
      {
      name = hostname;
      value = inputs.nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        modules = [
          ../hosts/darwin.nix
          ../hosts/${hostname}/darwin.nix
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              extraSpecialArgs = specialArgs;
              users.${username} = {
                imports = [
                  ../hosts/home.nix
                  ../hosts/${hostname}/home.nix
                ];
              };
            };
          }
        ];
      };
    };
}
