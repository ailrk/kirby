{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.rofi;
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  options.kirby.program.rofi = {
    enable = mkEnableOption "Enable rofi application launcher";
  };

  config = mkIf cfg.enable {
      home.packages = [ pkgs.rofi ];
      xdg.configFile."rofi/scripts".source = ./scripts;
      xdg.configFile."rofi/theme".source = ./theme;
      xdg.configFile."rofi/styles".source = ./styles;
      xdg.dataFile."fonts/Feather.ttf".source = ./fonts/Feather.ttf;

      # link binaries to scripts
      xdg.configFile."scripts/apps.sh".source = link ./scripts/apps.sh;
      xdg.configFile."scripts/battery.sh".source = link ./scripts/battery.sh;
      xdg.configFile."scripts/launcher.sh".source = link ./scripts/launcher.sh;
      xdg.configFile."scripts/network.sh".source = link ./scripts/network.sh;
      xdg.configFile."scripts/powermenu.sh".source = link ./scripts/powermenu.sh;
  };

}
