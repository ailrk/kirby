{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.home.service.dropbox;
in
{
  options.kirby.home.service.dropbox = {
    enable = mkEnableOption "Enable dropbox";
  };

  config = mkIf cfg.enable {
    services.dropbox = {
      enable = true;
    };
  };
}
