{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      act
      ansible
      goreleaser
    ];
  };
  shell.aliases.gr = "goreleaser";

  terminal = "kitty";
  development = {
    enable = true;
    gcp.enable = true;
  };
  nvim.remote = true;
  # ruby.enable = true;
  python.enable = true;
  go = {
    enable = true;
    pkg = pkgs.go_1_24;
  };

  shell = {
    supported = ["zsh"];
    paths = [
      "/Users/eduguay/.dotnet/tools"
    ];
    extra = [
      ''export LANG="en_CA.UTF-8"''
      ''export EFLOW_CONFIG=~/.eflow.config.json''
      ''export EFLOW_DOMAINS=~/.eflow.domains.json''
      ''export EFPAY_CONFIG=~/.efpay.config.json''
      ''export EF_FRONTEND_REVAMP_ROOT=~/Projects/frontend-revamp''
      ''export EF_WORKSPACE_PATH=~/Projects''
      ''export NODE_OPTIONS="--max_old_space_size=16384 --no-experimental-fetch"''
      ''export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)''
    ];
  };
}
