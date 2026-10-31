{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.labwc;
  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
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

    xdg.configFile."labwc/environment".source =
      symlink "${home}/program/labwc/environment";

    xdg.configFile."labwc/menu.xml".source =
      symlink "${home}/program/labwc/menu.xml";

    xdg.configFile."labwc/rc.xml".source =
      symlink "${home}/program/labwc/rc.xml";
  };
}
