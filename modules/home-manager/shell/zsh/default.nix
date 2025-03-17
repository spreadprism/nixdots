{
  pkgs,
  lib,
  config,
  flakeRoot,
  username,
  ...
}: let
  cfg = config.shell.zsh;
  args = {inherit pkgs lib config flakeRoot username;};
in {
  options.shell.zsh.enable = lib.mkEnableOption "Use zsh";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # zsh-syntax-highlighting
      # zsh-completions
      # zsh-autosuggestions
    ];

    programs = {
      zsh = {
        enable = true;
        shellAliases = {
          # cli
          ls = "eza";
          cat = "bat";
          w = "watch -n 1";
          # terraform
          v = "nvim";
        };
      };
      starship.enableZshIntegration = true;
    };
  };
}
