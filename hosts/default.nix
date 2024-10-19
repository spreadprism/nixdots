{ lib, nixpkgs, dotfiles, isNixOS, isMacOS, user, pkgs, home-manager, nix-darwin, ... }:
let
  all_paths = builtins.readDir ./. ;
  all_dirs = builtins.filter (key: all_paths.${key} == "directory") (builtins.attrNames all_paths);

  nixos_hosts = builtins.filter (host: builtins.pathExists ./${host}/configuration.nix) all_dirs;
  macos_hosts = builtins.filter (host: builtins.pathExists ./${host}/darwin.nix) all_dirs;

  hardware_hosts = nixos_hosts ++ macos_hosts;
  other_hosts = builtins.filter (host: builtins.pathExists ./${host}/home.nix && !builtins.elem host hardware_hosts) all_dirs;

  mkHost = host: isNixOS: isMacOS:
    let
      pkgs = import ./${host} { inherit pkgs; };
      extraArgs = { inherit user dotfiles; hostname = host;  };
      extraModules = extraModules ++ {};
    in
    if isNixOS
    then
    # TODO: Should fix this once I use NixOS
    nixpkgs.lib.nixosSystem
    {
      specialArgs = extraArgs;
      modules = [
        ./${host}
        ./${host}/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = extraArgs;
          home-manager.users.${user} = {
            imports = [
              ./home.nix
            ] ++ lib.optional (builtins.pathExists ./${host}/home.nix) ./${host}/home.nix;
          };
        }
      ];

    }
    else if isMacOS
    then
      nix-darwin.lib.darwinSystem
      {

      }
  else
    home-manager.lib.homeManagerConfiguration
    {
      inherit lib;
      inherit pkgs;
      extraSpecialArgs = extraArgs;
      modules = [
        # ./home.nix
        # ./${host}/home.nix
      ];
    };
in
  if isNixOS
    then
    builtins.listToAttrs (map (path: { name = builtins.baseNameOf path; value = mkHost user isNixOS isMacOS; }) nixos_hosts)
  else if isMacOS
    then
    builtins.listToAttrs (map (path: { name = builtins.baseNameOf path; value = mkHost user isNixOS isMacOS; }) macos_hosts)
  else
    builtins.listToAttrs (map (path: { name = "${user}@${builtins.baseNameOf path}"; value = mkHost (builtins.baseNameOf path) isNixOS isMacOS; }) other_hosts)
