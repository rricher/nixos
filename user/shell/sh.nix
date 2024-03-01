{ config, pkgs, ... }:
let
  myAliases = {
    ls = "eza";
    ll = "ls -la";
    cat = "bat";
    htop = "btm";
    fd = "fd -Lu";
  };
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = myAliases;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

   home.packages = with pkgs; [
    neofetch lolcat onefetch
    gnugrep gnused
    bat eza bottom fd bc
  ];
}
