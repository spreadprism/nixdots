{
  inputs,
  pkgs,
  lib,
  config,
  flakeRoot,
  ...
}: let
  devEnabled = config.development.enable;
in {
  imports = [ inputs.neovim.homeModule ];
  options = {
    nvim.remote = lib.mkEnableOption "include remote plugins";
  };
  # TODO: Unable to override the cfgs
  config = lib.mkIf devEnabled {
    nvim = {
      enable = true;
      packageNames = [ "nvim" ];
    };
  };
}
