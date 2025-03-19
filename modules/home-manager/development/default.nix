{lib, ...}: let
  readAll = directory: (map (path: "${directory}/${path}") (builtins.filter (name: name != "default.nix") (builtins.attrNames (builtins.readDir directory))));
  languages = readAll ./languages;
  tools = readAll ./tools;
in {
  imports =
    builtins.concatLists [
      languages
      tools
    ]
    ++ [
      ./lsp/codelldb.nix
    ];
  options = {
    development.enable = lib.mkEnableOption "Enable development features";
  };
}
