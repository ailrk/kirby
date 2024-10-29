{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.polybar;
in
{
  options.kirby.program.polybar = {
    enable = mkEnableOption "Enable polybar";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      polybar
    ];

    xdg.configFile."polybar/start.sh" = {
      source = ./start.sh;
      executable = true;
    };
    xdg.configFile."polybar/config".source = ./config;
  };
}
