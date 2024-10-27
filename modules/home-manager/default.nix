{lib, pkgs, config, username, ...}:
let
  inherit (pkgs.stdenv) isDarwin;
  homeDirectory = if isDarwin
    then "/Users/${username}"
    else "/home/${username}";
  flakeRoot = "${homeDirectory}/nixdots";
  args = { inherit pkgs lib config flakeRoot username; };
in
{
  imports = [
    (import ./shell args)
    (import ./terminal args)
    (import ./development args)
  ];
}
