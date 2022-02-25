{ config, lib, pkgs, ... }:
with
lib;
{
  home.packages = with pkgs; [
    sxhkd
  ];

  xdg.configFile."sxhkd/sxhkdrc" = {
      source = ./sxhkdrc;
      executable = true;
  };
}
