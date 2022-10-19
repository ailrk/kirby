{ config, lib, pkgs, ... }:
with
lib;
{
  home.packages = with pkgs; [
   picom 
  ];

  services.picom.enable = true;

  xdg.configFile = {
    "compton/compton.conf".source = ./compton.conf;
  };
}
