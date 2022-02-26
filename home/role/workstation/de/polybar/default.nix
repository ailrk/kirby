{ config, lib, pkgs, ... }:
with
lib;
{
  services.polybar = {
    enable = true;
    config = ./config;
    script =  "polybar main &";
  };

  xdg.configFile."polybar/start.sh" = {
    source = ./start.sh;
    executable = true;
  };
}
