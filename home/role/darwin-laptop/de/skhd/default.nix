{ config, lib, pkgs, ... }:
with
lib;

{

  home.packages = with pkgs; [
    skhd
  ];

  xdg.configFile = {
    "skhd/skhdrc" = {
      source = ./skhdrc;
      executable = true;
    };
  };
}
