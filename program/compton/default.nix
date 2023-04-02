{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.bspwm;
in
{
  options.kirby.program.compton = {
    enable = mkEnableOption "Enable compton";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
     picom 
    ];

    services.picom.enable = true;

    xdg.configFile = {
      "compton/compton.conf".source = ./compton.conf;
    };
  };
}
