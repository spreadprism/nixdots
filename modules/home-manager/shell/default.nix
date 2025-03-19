{
  pkgs,
  lib,
  flakeRoot,
  ...
}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./zsh/zsh.nix
    ./bash.nix
    ./tools/direnv.nix
    ./tools/dircolor.nix
    ./tools/tmux.nix
    ./tools/starship.nix
    ./tools/zoxide.nix
  ];

  options.shell = {
    supported = mkOption {
      type = types.listOf (types.enum ["zsh" "bash"]);
      default = ["zsh"];
    };
    paths = mkOption {
      type = with types; listOf str;
      default = [];
    };
    envs = mkOption {
      type = with types; attrsOf str;
      default = {};
    };
    aliases = mkOption {
      type = with types; attrsOf str;
      default = {};
    };
    extra = mkOption {
      type = with types; listOf str;
      default = [];
    };
  };

  config = {
    shell = {
      aliases = {
        ls = "eza";
        cat = "bat";
        w = "watch -n 1";
      };
      paths = [
        flakeRoot
        "$HOME/.nix-profile/bin"
      ];
    };
    home.packages = with pkgs; [
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
}
