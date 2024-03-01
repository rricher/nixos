{ userSettings, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    enableOnBoot = false;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.users.${userSettings.username}.extraGroups = [ "docker" ];
}
