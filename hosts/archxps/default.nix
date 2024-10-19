{ pkgs, ... }:
let
  system = "x86_64-linux";
  system_pkgs = import pkgs { inherit system; };
in
{
  pkgs = system_pkgs;
}
