{ pkgs, lib, config, flakeRoot, username, ... }:
let
  args = { inherit pkgs lib config flakeRoot username; };
in
{
  imports = [
      (import ./zsh.nix args)
      (import ./bash.nix args)
      (import ./tmux/tmux.nix args)
  ];

  home = {
    sessionPath = [
      flakeRoot
      "$HOME/.nix-profile/bin"
    ];
    shellAliases = {
      ls = "eza";
      cat = "bat";
      w = "watch -n 1";
    };
    packages = with pkgs; [
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
      watch
    ];
  };

  programs = {
    starship.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/starship.toml";
  xdg.configFile."direnv/direnv.toml".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/direnv/direnv.toml";
}
