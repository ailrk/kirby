{ config, lib, pkgs, ... }:
with
lib;
{
  home.packages = with pkgs; [
    polybar
  ];

  xdg.configFile."polybar/start.sh" = {
    source = ./start.sh;
    executable = true;
  };
  xdg.configFile."polybar/config".source = ./config;
}
