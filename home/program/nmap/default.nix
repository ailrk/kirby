{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.home.program.nmap;
in
{
  options.kirby.home.program.nmap = {
    enable = mkEnableOption "Enable nmap";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.nmap ];
    xdg.configFile."nmap/scripts/vulners.nse".source = ./scripts/vulners.nse;
  };
}
