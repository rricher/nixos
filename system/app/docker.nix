{ userSettings, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.users.${userSettings.username}.extraGroups = [ "docker" ];
}
