{ config, lib, pkgs, ... }:
{

  imports = [
    ./pipewire.nix
    ./dbus.nix
  ];
  # displayManager.sddm = {
  #     enable = true;
  #     wayland.enable = true;
  #     enableHidpi = true;
  #   };
  services.xserver.displayManager.gdm.enable = true;
  environment.systemPackages = with pkgs;
    [ wayland waydroid thunar rofi waybar
    ];
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # Enable the X11 windowing system.
  services.xserver.enable = true;
}
