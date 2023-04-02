{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.service.dropbox;
in
{
  options.kirby.service.dropbox = {
    enable = mkEnableOption "Enable dropbox";
  };

  config = mkIf cfg.enable {
    services.dropbox = {
      enable = true;
    };
  };
}
