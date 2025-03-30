{ inputs, pkgs, ... }:
let
  inherit (pkgs) lib;
in
{
  options = {};
  config = {
    home.packages = with pkgs; [
      neovim
      figlet
      lolcat
      lua51Packages.luarocks
    ];
  };
}
