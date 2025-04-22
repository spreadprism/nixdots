{
  pkgs,
  lib,
  config,
  flakeRoot,
  ...
}: let
  enabled = config.shell.mux == "tmux";
in {
  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      tmux
    ];
    # BUG: this needs to be symlinked, otherwise there is a huge delay between nvim and tmux
    xdg.configFile.tmux.source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/modules/home-manager/shell/tools/tmux/tmux";
    shell.extra = [
      (builtins.readFile ./utils.sh)
    ];
  };
}
