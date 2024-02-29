{ config, pkgs, ... }:

{
  home.packages = [ pkgs.git ];
  programs.git.enable = true;
  # programs.git.userName = userSettings.name;
  # programs.git.userEmail = userSettings.email;
  programs.git.userName = "rricher";
  programs.git.userEmail = "ryanricher@gmail.com";
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    # safe.directory = "/home/" + userSettings.username + "/.dotfiles";
  };
}