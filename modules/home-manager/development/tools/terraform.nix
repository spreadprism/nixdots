{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.development.enable {
    home.packages = with pkgs; [
      terraform
    ];
    shell.aliases = {
      tf = "terraform";
    };

    programs.zsh.zplug = lib.mkIf config.programs.zsh.zplug.enable {
      plugins = [
        {
          name = "plugins/terraform";
          tags = ["from::oh-my-zsh"];
        }
      ];
    };
  };
}
