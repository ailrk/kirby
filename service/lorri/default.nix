{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.service.lorri;
in
{
  options.kirby.service.lorri = {
    enable = mkEnableOption "Enable the Lorri daemon for better nix development";
  };

  config = mkIf cfg.enable {
    services.lorri = {
      enable = true;
    };
  };
}
