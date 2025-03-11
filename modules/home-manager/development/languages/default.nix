{ pkgs, lib, config, flakeRoot, username, ... }:
let
  args = { inherit pkgs lib config flakeRoot username; };
in
{
  imports = [
    (import ./python.nix args)
    (import ./go.nix args)
  ];
}
