{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.rofi;
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
  };
}
