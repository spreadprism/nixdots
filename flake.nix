{
  description = "Multiplatform nix config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
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
      # INFO: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "24.05";
      utils = import ./utils { inherit inputs outputs stateVersion; };
      hosts = import ./hosts { inherit inputs outputs stateVersion utils; username = "avalon"; };
    in
    {
      inherit (hosts)
        nixosConfigurations
        darwinConfigurations
        homeConfigurations;
    };
}
