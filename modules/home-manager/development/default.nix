{lib, ...}: {
  imports = [
    ./languages/python.nix
    ./languages/go.nix
    ./languages/rust.nix
    ./tools/nvim.nix
    ./lsp/codelldb.nix
    ./tools/git.nix
  ];
  options = {
    development.enable = lib.mkEnableOption "Enable development features";
  };
}
