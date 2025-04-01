{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  devEnabled = config.development.enable;
in {
  imports = [inputs.neovim.homeModule];
  options = {
    nvim.remote = lib.mkEnableOption "include remote plugins";
  };
  config = lib.mkIf devEnabled {
    shell.aliases = {
      v = "nvim";
    };
    nvim = {
      enable = true;
      packageDefinitions.replace = {
        nvim = {pkgs, ...}: {
          categories = {
            go = config.go.enable;
            remote = config.nvim.remote;
          };
        };
      };
    };
  };
}
