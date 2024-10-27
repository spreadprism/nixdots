{ pkgs, lib, config, flakeRoot, username, ... }:
let
  args = { inherit pkgs lib config flakeRoot username; };
in
{
  imports = [
      (import ./kitty.nix args)
  ];
}
