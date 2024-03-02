{ config, lib, pkgs, ... }:
{

  imports = [
    ./pipewire.nix
    ./dbus.nix
  ];
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";
  };
  hardware = {
    nvidia.modesetting.enable = true;
  };
  environment.systemPackages = with pkgs; [
    waybar
    dunst
    libnotify
    swww
    wofi
  ];
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
