{
  inputs,
  outputs,
  extraArgs,
  ...
}: let
  args = {inherit inputs outputs extraArgs;};
in {
  inherit (import ./mkHome.nix args) mkHome;
  inherit (import ./mkDarwin.nix args) mkDarwin;
}
