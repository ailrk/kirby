{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.waybar;
in
{
  options.kirby.program.waybar = {
    enable = mkEnableOption "Enable waybar";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      waybar
    ];

    xdg.configFile."waybar/config".source = ./config;
    xdg.configFile."waybar/style.css".source = ./style.css;
    xdg.configFile."waybar/battery.sh".source = ./battery.sh;
    xdg.configFile."waybar/im.sh".source = ./im.sh;
  };
}
