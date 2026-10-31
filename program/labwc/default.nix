{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.labwc;
in
{
  options.kirby.program.labwc = {
    enable = mkEnableOption "Enable labwc";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      labwc
    ];

    xdg.configFile."labwc/autostart" = {
      source = ./autostart;
      executable = true;
    };

    xdg.configFile."labwc/environment".source = ./environment;
    xdg.configFile."labwc/menu.xml".source = ./menu.xml;
    xdg.configFile."labwc/rc.xml".source = ./rc.xml;
  };
}
