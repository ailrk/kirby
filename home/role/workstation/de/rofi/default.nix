{ config, lib, pkgs, ... }:
with
lib;
{
  home.packages = with pkgs; [
    rofi
  ];

  xdg.configFile."/scripts/rofio" = {
      source = ./rofio;
      executable = true;
  };
}
