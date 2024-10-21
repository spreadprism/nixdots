{ inputs, outputs, stateVersion, ... }:
{
  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];

  mkHome = hostname: username:
    let conf = import ../hosts/${hostname} { inherit inputs outputs stateVersion; };
  in
  {

  };
}
