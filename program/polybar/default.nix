{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.polybar;
in
{
  options.kirby.program.polybar = {
    enable = mkEnableOption "Enable polybar";
    colorMode = mkOption {
      type = types.enum ["dark" "light"];
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      polybar
    ];

    xdg.configFile."polybar/start.sh" = {
      source = ./start.sh;
      executable = true;
    };
    xdg.configFile."polybar/colors.ini".source =
      if cfg.colorMode == "dark"
      then ./colors-dark.ini
      else ./colors-dark.ini;
    xdg.configFile."polybar/config".source = ./config;
  };
}
