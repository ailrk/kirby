{ config, lib, pkgs, ...}:
with
lib;
{

  home.packages = with pkgs; [
    yabai
  ];

  xdg.configFile = {
    "yabai/yabairc" = {
      source = ./yabairc;
      executable = true;
    };
  };

}
