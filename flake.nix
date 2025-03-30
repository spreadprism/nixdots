{
  description = "Nix (NixOS, MacOS, Home-manager)";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    neovim = {
      url = "github:spreadprism/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # utils
    flake-utils.url = "github:numtide/flake-utils";
    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    stateVersion = "24.05";
    forAllSystems = nixpkgs.lib.genAttrs inputs.flake-utils.lib.defaultSystems;
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    inherit
      (import ./hosts {inherit inputs outputs stateVersion;})
      nixosConfigurations
      darwinConfigurations
      homeConfigurations
      ;
  };
}
