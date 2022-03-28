{ config, lib, pkgs, ... }:
with
lib;
{
  home.packages = with pkgs; [
    bspwm
    feh
  ];

  xdg.configFile."bspwm/bspwmrc" = {
      source = ./bspwmrc;
      executable = true;
  };
}
