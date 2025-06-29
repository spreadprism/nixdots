# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  nixdots = pkgs.buildGoModule {
    name = "nixdots";
    src = ./nixdots;
    vendorHash = "sha256-hqWobWhUDB+J00QTlJw5/oKiuOm6rZgJGJyMdv/nwqY=";
  };
}
