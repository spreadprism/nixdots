{
  inputs,
  extraArgs,
  ...
}: let
  inherit (inputs) nix-darwin nix-homebrew home-manager sops-nix;
in {
  mkDarwin = hostname: let
    hostCfg =
      if builtins.pathExists ../../hosts/${hostname}/default.nix
      then import ../../hosts/${hostname} {}
      else {};
    getOrDefault = key: default:
      if builtins.hasAttr key hostCfg
      then builtins.getAttr key hostCfg
      else default;

    system = getOrDefault "system" "x86_64-darwin";
    username = getOrDefault "username" "avalon";
    homeDirectory = "/Users/${username}";
    flakeRoot = "${homeDirectory}/nixdots";
    specialArgs =
      {
        inherit username system hostname flakeRoot;
      }
      // extraArgs;
  in {
    name = hostname;
    value = nix-darwin.lib.darwinSystem {
      inherit specialArgs;
      inherit system;
      modules = [
        ../defaults/darwin.nix
        ../../hosts/${hostname}/darwin.nix
        sops-nix.darwinModules.sops
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = system == "aarch64-darwin";
            user = username;
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = specialArgs;
            users.${username} = {
              imports = [
                sops-nix.homeManagerModule
                ../defaults/home.nix
                ../../hosts/${hostname}/home.nix
                ../../modules/home-manager
              ];
            };
          };
        }
      ];
    };
  };
}
