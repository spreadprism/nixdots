{
  pkgs,
  lib,
  flakeRoot,
  ...
}: let
  inherit (lib) mkOption types;
  readNix = path: builtins.filter (x: lib.hasSuffix ".nix" x) (lib.filesystem.listFilesRecursive path);
in {
  imports =
    [
      ./zsh/zsh.nix
      ./bash.nix
    ]
    ++ readNix ./tools;

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
    mux = mkOption {
      type = types.enum ["tmux" "zellij"];
      default = "tmux";
    };
  };

  config = {
    shell = {
      aliases = {
        ls = "eza";
        cat = "bat";
        w = "watch -n 1 ";
      };
      paths = [
        flakeRoot
        "$HOME/.nix-profile/bin"
        "$HOME/.bin"
      ];
    };
    home.packages = with pkgs; [
      ripgrep
      fzf
      jq
      yq-go
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
