{ pkgs, lib, config, flakeRoot, ... }:
{
  imports = [
    (import ./nvim.nix { inherit pkgs lib config flakeRoot; })
  ];
}
