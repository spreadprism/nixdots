{
  homeDirectory,
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    age
  ];
  sops = {
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
  };
  sops.secrets.secret_message = {};
  shell.extra = [
    ''export SECRET_MESSAGE=$(cat ${config.sops.secrets.secret_message.path})''
  ];
}
