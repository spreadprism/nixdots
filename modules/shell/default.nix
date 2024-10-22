{ pkgs, lib, config, ... }:
{
  imports = [
    ./zsh.nix
    ./bash.nix
  ];
}
