{pkgs, lib, config, flakeRoot, ...}:
{
  options = {

  };
  config = {
    home.packages = with pkgs; [
      neovim
      figlet
      lolcat
      lua51Packages.luarocks
    ];
  };
}
