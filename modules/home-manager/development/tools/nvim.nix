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
  options = {
    nvim.remote = lib.mkEnableOption "include remote plugins";
  };
  config = lib.mkIf devEnabled {
    home.shellAliases.v = "nvim";
    nvim = (let
    inherit (inputs.neovim) utils packageDefinitions;
  in {
    enable = true;
    packageNames = [ "nvim" ];
    packages = {
      nvim = utils.mergeCatDefs packageDefinitions.chrisNvim ({ pkgs, ... }: {
        categories = {
          go = config.go.enable;
          remote = config.nvim.remote;
        };
      });
    };
  });
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
