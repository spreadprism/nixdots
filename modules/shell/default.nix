{ pkgs, lib, config, flakeRoot, ... }:
{
  imports = [
    (import ./zsh.nix { inherit pkgs lib config flakeRoot; })
    (import ./bash.nix { inherit pkgs lib config flakeRoot; })
  ];
}
