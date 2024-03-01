{ config, pkgs, ... }:

{
  programs.vim = {
  enable = true;
  settings = {
      expandtab = true;
      tabstop = 2;
      ignorecase = true;
      copyindent = true;
    };
  };
}