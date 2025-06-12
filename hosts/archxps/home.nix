{pkgs, ...}: {
  targets.genericLinux.enable = true;
  home = {
    packages = with pkgs; [
    ];
  };

  shell.supported = ["zsh"];
  desktop = "hyprland";
  terminal = "ghostty";
  shell.aliases.sudo = "sudo-rs";

  development.enable = true;
  python.enable = true;
  go.enable = true;
  rust.enable = true;
  java.enable = true;
}
