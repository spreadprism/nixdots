{...}: {}
  # mkNixOS = hostname: default_username: let
  #   host_conf = import ../hosts/${hostname} args;
  #   system =
  #     if builtins.hasAttr "system" host_conf
  #     then host_conf.system
  #     else "x86_64-linux";
  #   username =
  #     if builtins.hasAttr "username" host_conf
  #     then host_conf.username
  #     else default_username;
  #   specialArgs = args // {inherit username system hostname;};
  # in {
  #   name = hostname;
  #   value = inputs.nixpkgs.lib.nixosSystem {
  #     inherit system;
  #     inherit specialArgs;
  #     modules = [
  #       inputs.sops-nix.nixosModules.sops
  #       ./configuration.nix
  #       ./${hostname}/configuration.nix
  #       ../modules/shared
  #       inputs.home-manager.nixosModules.home-manager
  #       {
  #         home-manager.useGlobalPkgs = true;
  #         home-manager.extraSpecialArgs = specialArgs;
  #         home-manager.users.${username} = {
  #           imports =
  #             [
  #               ./home.nix
  #               ../modules/home-manager
  #             ]
  #             ++ inputs.nixpkgs.lib.optionals (builtins.pathExists ./${hostname}/home.nix) [
  #               ./${hostname}/home.nix
  #             ];
  #         };
  #       }
  #     ];
  #   };
  # };
