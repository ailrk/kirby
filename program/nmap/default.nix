{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.nmap;
in
{
  options.kirby.program.nmap = {
    enable = mkEnableOption "Enable nmap";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.nmap ];
    xdg.configFile."nmap/scripts/vulners.nse".source = ./scripts/vulners.nse;
  };
}
