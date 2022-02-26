{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.home.service.lorri;
in
{
  options.kirby.home.service.lorri = {
    enable = mkEnableOption "Enable the Lorri daemon for better nix development";
  };

  config = mkIf cfg.enable {
    services.lorri = {
      enable = true;
    };
  };
}
