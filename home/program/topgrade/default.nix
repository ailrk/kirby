{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.home.program.topgrade;
in
{
  options.kirby.home.program.topgrade = {
    enable = mkEnableOption "Enable topgrade for convenient upgrades across package managers";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.topgrade ];
    xdg.configFile."topgrade.toml".source = ./topgrade.toml;
  };
}
