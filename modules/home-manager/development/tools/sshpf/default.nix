{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "sshpf" (builtins.readFile ./sshpf))
  ];
}
