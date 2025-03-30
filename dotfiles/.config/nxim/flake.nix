{
  description = "My neovim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };
  outputs = { self, nixpkgs, nixCats, ...}@inputs: let
    inherit (nixCats) utils;
    luaPath = "${./.}";
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forEachSupportedSystem = nixpkgs.lib.genAttrs supportedSystems (system: {
      inherit system;
      pkgs = import nixpkgs { inherit system; };
    });
    extra_pkg_config = {
      allowUnfree = true;
    };
  in {
    packages = forEachSupportedSystem( { pkgs, ... }: rec {
      nvim = import ./nix/nvim.nix { inherit inputs pkgs; };
      default = nvim;
    });
    devShells = forEachSupportedSystem( {pkgs, ...}: {
      default = pkgs.mkShell {
        name = "nvim-devShell";
        buildInputs = with pkgs; [
          lua-language-server
          nil
          stylua
          luajitPackages.luacheck
          nvim-dev
        ];
        shellHook = ''
          # symlink the .luarc.json generated in the overlay
          ln -fs ${pkgs.nvim-luarc-json} .luarc.json
          # allow quick iteration of lua configs
          ln -Tfns $PWD/nvim ~/.config/nvim-dev
        '';
      };
    });
  };
}
