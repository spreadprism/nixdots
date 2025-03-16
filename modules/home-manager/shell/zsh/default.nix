{ pkgs, lib, config, flakeRoot, username, ... }:
let
  cfg = config.shell.zsh;
  args = { inherit pkgs lib config flakeRoot username; };
in
{
  options.shell.zsh.enable = lib.mkEnableOption "Use zsh";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
    [
        # zsh-syntax-highlighting
        # zsh-completions
        # zsh-autosuggestions
    ];

    programs = {
      zsh.enable = true;
      starship.enableZshIntegration = true;
    };

    home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.zshrc";
    home.file.".alias.zsh".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.alias.zsh";

    # home.file.".nix/shell/alias.zsh".source = ./alias.zsh;
  };
  # imports = [
  #   (import ./plugins args)
  # ];
}
