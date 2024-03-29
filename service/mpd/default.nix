{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.service.mpd;
in
{
  options.kirby.service.mpd = {
    enable = mkEnableOption "Enable mpd for local music playing";
  };

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "/media/audio";
      playlistDirectory = "${config.home.homeDirectory}/media/audio/mpd-playlists";
      dataDir = "${config.xdg.dataHome}/mpd";
      extraConfig = ''
        audio_output {
          type    "pulse"
          name    "pulse audio"
        }
      '';
    };
  };
}
