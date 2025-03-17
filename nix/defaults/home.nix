{
  lib,
  pkgs,
  stateVersion,
  config,
  username,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
  homeDirectory =
    if isDarwin
    then "/Users/${username}"
    else "/home/${username}";
  flakeRoot = "${homeDirectory}/nixdots";
in {
  # INFO: Let home-manager manage itself
  programs.home-manager.enable = true;
  # INFO: Enable flakes
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
  };
  home = {
    inherit stateVersion;
    inherit username;
    inherit homeDirectory;
    packages = with pkgs;
      [
        git
        gh
        ripgrep
        nh
      ]
      ++ lib.optionals isLinux [
      ]
      ++ lib.optionals isDarwin [
      ];
  };
  home.file.".nix/shell/nix.sh".text = ''
    export PATH="$HOME/.nix-profile/bin:$PATH:"
    export PATH="$PATH:$HOME/.nix/bin"
  '';
  home.file.".nix/shell/darwin.sh".text =
    if isDarwin
    then ''export PATH="$PATH:/opt/homebrew/bin" ''
    else '''';
  home.file.".nix/bin/nixdots".source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/nixdots";
}
