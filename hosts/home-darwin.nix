{ stateVersion, user, ... }:
{
  imports = [
  ];

  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
  };

  services = { };

  programs = {
  };

  home.stateVersion = stateVersion;
}
