{ config, lib, pkgs, ... }:
with
lib;
{
  services.polybar = {
    enable = true;
    config = ./config;
    script =  "$HOME/.config/polybar/start.sh";
  };

  xdg.configFile."polybar/start.sh" = {
    source = ./start.sh;
    executable = true;
  };
}
