{ config, lib, pkgs, ... }:
{

  imports = [
    ./pipewire.nix
    ./dbus.nix
    ../system/hardware/nvidia.nix
  ];
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
