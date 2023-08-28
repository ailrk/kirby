{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.nemo;
in
{
  options.kirby.program.nemo = {
    enable = mkEnableOption "Enable the nemo file browser";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cinnamon.nemo
    ];
  };
}
