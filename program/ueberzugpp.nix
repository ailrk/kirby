{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.ueberzugpp;
in
{
  options.kirby.program.ueberzugpp = {
    enable = mkEnableOption "Enable ueberzugpp";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ueberzugpp
    ];
  };
}
