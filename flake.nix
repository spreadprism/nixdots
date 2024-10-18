{
  description = "My Nix(\"OS\" or \"\") configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, home-manager, nix-darwin, nixpkgs, unstable, ... }:
    let
      # INFO: Define the configuration to be applied to both stable and unstable packages
      commonConfig = { allowUnfree = true; };

      unstablePkgs = import unstable {
        config = commonConfig;
      };

      pkgs = import nixpkgs {
        config = commonConfig // {
          packageOverrides = pkgs: {
            unstable = unstablePkgs;
          };
        };
      };

      user = "avalon";
      # secrets = import ./secrets; # TODO: add secrets
      dotfiles = ./dotfiles;

      commonInherits = {
        inherit pkgs;
        inherit home-manager nix-darwin;
        inherit user dotfiles;
      };
    in
      {
      nixosConfigurations = import ./hosts (commonInherits // {
        isNixOS = true;
        isMacOS = false;
      });

      darwinConfigurations = import ./hosts (commonInherits // {
        isNixOS = false;
        isMacOS = true;
      });

      # INFO: home-manager switch --flake .
      homeConfigurations = import ./hosts (commonInherits // {
        isNixOS = false;
        isMacOS = false;
      });
    };
}
