{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ryan";
  home.homeDirectory = "/home/ryan";
  
  imports = [
    ../../user/shell/sh.nix
    ../../user/app/git.nix
    # ../../user/app/1password.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    vscode
    git
    zsh
    alacritty
    firefox
    wine
    vlc
    "1password"
    "1password-gui"
  ];

  programs.vscode.enable = true;

  xdg.enable = true;
  # xdg.userDirs = {
  #   enable = true;
  #   createDirectories = true;
  #   music = "${config.home.homeDirectory}/Media/Music";
  #   videos = "${config.home.homeDirectory}/Media/Videos";
  #   pictures = "${config.home.homeDirectory}/Media/Pictures";
  #   templates = "${config.home.homeDirectory}/Templates";
  #   download = "${config.home.homeDirectory}/Downloads";
  #   documents = "${config.home.homeDirectory}/Documents";
  #   desktop = null;
  #   publicShare = null;
  #   extraConfig = {
  #     XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
  #     XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
  #     XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
  #     XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
  #     XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
  #     XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
  #   };
  # };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  # xdg.mimeApps.associations.added = {
  #   "application/octet-stream" = "flstudio.desktop;";
  # };

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    # SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
