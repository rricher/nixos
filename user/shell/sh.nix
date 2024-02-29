{ config, pkgs, ... }:
let
  myAliases = {
    ls = "eza --icons -l -T -L=1";
    ll = "ls -l";
    cat = "bat";
    htop = "btm";
    fd = "fd -Lu";
    neofetch = "disfetch";
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
    disfetch lolcat onefetch
    gnugrep gnused
    bat eza bottom fd bc
  ];
}
