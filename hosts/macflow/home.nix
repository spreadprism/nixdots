{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      terraform
      act
    ];
  };

  shell.supported = ["zsh"];
  terminal = false;
  development = {
    enable = true;
    gcp.enable = true;
  };
  go = {
    enable = true;
    pkg = pkgs.go_1_24;
  };
}
