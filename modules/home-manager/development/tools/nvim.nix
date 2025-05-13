{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.neovim.homeModule];
  options = {
    nvim.remote = lib.mkEnableOption "include remote plugins";
    robot.enable = lib.mkEnableOption "add robot support to neovim";
  };
  config = lib.mkIf config.development.enable {
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
              rust = config.rust.enable;
              terraform = true;
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
