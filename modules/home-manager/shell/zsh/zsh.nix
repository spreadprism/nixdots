{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mapAttrsToList;
  # replace list of string into a single array
  env = builtins.map (path: "export PATH=$PATH:${path}") config.shell.paths;
  aliases = mapAttrsToList (key: value: "alias ${key}=\"${value}\"") config.shell.aliases;
in {
  config = {
    programs = {
      zsh = mkIf (builtins.elem "zsh" config.shell.supported) {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        autosuggestion = {
          enable = true;
          strategy = [
            "match_prev_cmd"
            "completion"
          ];
        };
        history = rec {
          size = 5000;
          save = size;
          path = "$HOME/.zsh_history";
          saveNoDups = true;
        };
        zplug = {
          enable = true;
          plugins = [
            {name = "zsh-users/zsh-syntax-highlighting";}
            {name = "zsh-users/zsh-completions";}
            {name = "zsh-users/zsh-autosuggestions";}
            # INFO: fzf
            {name = "joshskidmore/zsh-fzf-history-search";}
            {name = "Aloxaf/fzf-tab";}
            # INFO: OMZ::plugins
            {
              name = "plugins/sudo";
              tags = ["from::oh-my-zsh"];
            }
            {
              name = "plugins/dirhistory";
              tags = ["from::oh-my-zsh"];
            }
          ];
        };
        initExtra = lib.concatStringsSep "\n" [
          (builtins.readFile ./zstyles.zsh)
          (builtins.readFile ./previous_next_dir.zsh)
          (builtins.readFile ./keybinds.zsh)
        ];
        envExtra = lib.concatStringsSep "\n" (builtins.concatLists [env aliases config.shell.extra]);

      };
    };
  };
}
