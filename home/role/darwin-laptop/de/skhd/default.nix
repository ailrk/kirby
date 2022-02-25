{ config, lib, pkgs, ... }:
with
lib;
{
  xdg.configFile = {
    "skhd/skhdrc" = {
      source = ./skhdrc;
      executable = true;
    };
  };
}
