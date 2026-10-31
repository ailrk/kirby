{ config, lib, ... }:
with lib;
let
  cfg = config.kirby.service.dunst;
in
{
  options.kirby.service.dunst = {
    enable = mkEnableOption "Enable dunst notification daemon";
  };

  config = mkIf cfg.enable {
    services.dunst.enable = true;

    xdg.configFile."dunst/dunstrc".source = ./dunstrc;
  };
}
