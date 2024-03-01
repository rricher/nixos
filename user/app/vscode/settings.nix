{ config, pkgs, ... }:
{
  programs.vscode = {
    userSettings = {
      "editor.fontSize" = 20;
      "editor.renderWhitespace" = "boundary";
      "[nix]"."editor.tabSize" = 2;
    };
  };
}