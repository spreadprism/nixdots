{ inputs, outputs, stateVersion, ... }:
let
  configurator = import ./configurator.nix { inherit inputs outputs stateVersion; };
in
{
  inherit (configurator) forAllSystems mkHome mkDarwin;
}
