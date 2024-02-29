{ config, lib, pkgs, ... }:
{
  services.journald.extraConfig = "SystemMaxUse=50M\nSystemMaxFiles=10";
  services.journald.rateLimitBurst = 500;
  services.journald.rateLimitInterval = "30s";
}
