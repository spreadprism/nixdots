{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      goreleaser
    ];
  };

  terminal = "kitty";
  development = {
    enable = true;
    gcp.enable = true;
  };
  nvim.remote = true;
  ruby.enable = true;
  python.enable = true;
  robot.enable = true;
  dotnet.enable = true;
  scala.enable = true;
  go = {
    enable = true;
    pkg = pkgs.go_1_24;
  };

  tools.act.flags = [
    "-P ef-hosted-runner=gcr.io/production-1309/actions-runner"
    "--pull=false"
    ''-s DEV_SA=$(cat ~/.config/gcloud/application_default_credentials.json | tr -d '\r\n')''
  ];
  shell = {
    supported = ["zsh"];
    aliases.gr = "goreleaser";
    paths = [
      "/Users/eduguay/.dotnet/tools"
    ];
    extra = [
      ''export DOCKER_HOST=unix://$(podman machine inspect | jq '.[0] | .ConnectionInfo | .PodmanSocket | .Path' -r)''
      ''export LANG="en_CA.UTF-8"''
      ''export EFLOW_CONFIG=~/.eflow.config.json''
      ''export EFLOW_DOMAINS=~/.eflow.domains.json''
      ''export EFPAY_CONFIG=~/.efpay.config.json''
      ''export EF_FRONTEND_REVAMP_ROOT=~/Projects/frontend-revamp''
      ''export EF_WORKSPACE_PATH=~/Projects''
      ''export NODE_OPTIONS="--max_old_space_size=16384 --no-experimental-fetch"''
      ''export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)''
      "source <(devstack completion zsh)"
      "source <(efctl completion zsh)"
    ];
  };
}
