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
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };
  outputs = { self, nixpkgs, home-manager, nix-darwin, nix-homebrew, ... }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "24.05";
      username = "avalon"; # INFO: Default username for most hosts
      in
    {
      inherit (import ./hosts { inherit inputs outputs stateVersion username; })
        nixosConfigurations
        darwinConfigurations
        homeConfigurations;
    };
}
