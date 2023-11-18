{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.program.dunst;
in
{
  options.kirby.program.dunst = {
    enable = mkEnableOption "Enable dunst notification daemon";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dunst
    ];

    services.dunst.enable = true;

    xdg.configFile."dunst/dunstrc".source = ./dunstrc;
  };
}
