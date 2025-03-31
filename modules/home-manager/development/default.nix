{inputs, lib, ...}: let
  readAll = directory: (map (path: "${directory}/${path}") (builtins.filter (name: name != "default.nix") (builtins.attrNames (builtins.readDir directory))));
  languages = readAll ./languages;
  tools = readAll ./tools;
in {
  imports =
    [
      ./lsp/codelldb.nix
      ./tools/gcloud.nix
      ./tools/git.nix
      ./tools/nvim.nix
      ./tools/podman.nix
      ./tools/kubernetes.nix
      ./languages/go.nix
      ./languages/python.nix
      ./languages/rust.nix
    ];
  options = {
    development.enable = lib.mkEnableOption "Enable development features";
  };
}
