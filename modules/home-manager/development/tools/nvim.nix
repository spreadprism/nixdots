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
    robot.enable = lib.mkEnableOption "add robot support to neovim";
  };
  config = lib.mkIf devEnabled {
    shell = {
      aliases.v = "nvim";
      envs.EDITOR = "nvim";
    };
    nvim = {
      enable = true;
      packageDefinitions.replace = {
        nvim = {...}: {
          categories = {
            language = {
              go = config.go.enable;
              python = config.python.enable;
              robot = config.robot.enable;
              ruby = config.ruby.enable;
              proto = true;
              docker = true;
            };
            tmux = config.shell.mux == "tmux";
            remote = config.nvim.remote;
            devtools = true;
          };
        };
      };
    };
  };
}
