{ pkgs, lib, config, flakeRoot, username, ... }:
let
  args = { inherit pkgs lib config flakeRoot username; };
in
{
  imports = [
      (import ./zsh.nix args)
      (import ./bash.nix args)
      (import ./tmux.nix args)
  ];

  home.packages = with pkgs;
  [
      ripgrep
      fzf
      jq
      fd
      jqp
      bat
      eza
      zoxide
      wget
      curl
  ];

  programs.starship.enable = true;
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/starship.toml";
  xdg.configFile."direnv/direnv.toml".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/direnv/direnv.toml";
}
