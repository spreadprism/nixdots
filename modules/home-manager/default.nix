{...}: {
  imports = [
    ./desktop
    ./shell
    ./terminal
    ./development
    ./sops.nix
  ];
  xdg.enable = true;
}
