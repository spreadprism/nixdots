{
  inputs,
  pkgs,
  lib,
  config,
  flakeRoot,
  ...
}: let
  devEnabled = config.development.enable;
in {
  imports = [ inputs.neovim.homeModule];
  config = lib.mkIf devEnabled {
    nvim.enable = true;
    # home.shellAliases.v = "nvim";
    # home.packages = with pkgs; [
    #   neovim
    #   figlet
    #   lolcat
    #   lua51Packages.luarocks
    # ];
    #
    # xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/nvim";
    # xdg.configFile."figlet/ANSI_Shadow.flf".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/figlet/ANSI Shadow.flf";
    # shell = {
    #   paths = [
    #     "$HOME/.local/share/nvim/mason/bin"
    #   ];
    #   extra = [
    #     "export NVIM_LISTEN_ADDRESS=/tmp/nvim.socket"
    #   ];
    # };
  };
}
