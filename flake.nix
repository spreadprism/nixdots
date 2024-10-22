{
  description = "Nix (NixOS, MacOS, Home-manager)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nix-darwin, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      dotfiles = ./dotfiles;
      modules = ./modules;
      stateVersion = "24.05";
      username = "avalon"; # INFO: Default username for home-manager configs
      in
    {
      inherit (import ./hosts { inherit inputs outputs stateVersion username dotfiles modules; })
        nixosConfigurations
        darwinConfigurations
        homeConfigurations;
    };
}
