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
      xdg.configFile."rofi/img".source = ./img;

      xdg.configFile."rofi/scripts".source = ./scripts;
      xdg.configFile."rofi/theme".source = ./theme;
      xdg.configFile."rofi/styles".source = ./styles;

      # link binaries to scripts
      xdg.configFile."scripts/launcher.sh".source = link ./scripts/launcher.sh;
      xdg.configFile."scripts/quickaccess.sh".source = link ./scripts/quickaccess.sh;
      xdg.configFile."scripts/powermenu.sh".source = link ./scripts/powermenu.sh;
  };
}
