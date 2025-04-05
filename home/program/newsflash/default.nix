{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.newsflash;
in
{
  options.kirby.program.newsflash = {
    enable = mkEnableOption "Enable newsflash";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.newsflash ];
  };
}
