{ config, pkgs, ... }:

{
  imports = [
    ./keybindings.nix
    ./settings.nix
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
    ];
  };
}