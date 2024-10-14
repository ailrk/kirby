{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.bspwm;
in
{
  options.kirby.program.bspwm = {
    enable = mkEnableOption "Enable bspwm window manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bspwm
      feh
    ];

    xdg.configFile."bspwm/configs.sh".source = ./configs.sh;
    xdg.configFile."bspwm/background".source = ./background;
  };
}
