{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.service.ollama;
in
{

  options.kirby.service.ollama = {
    enable = mkEnableOption "Enable ollama";
  };


  config = mkIf cfg.enable {
    # Add Ollama to your profile
    home.packages = [
      pkgs.ollama
    ];

    # Define a user-level systemd service
    systemd.user.services.ollama = {
      Unit = {
        Description = "Ollama API server";
        After = [ "network.target" ];
      };
      Service = {
        ExecStart = "${pkgs.ollama}/bin/ollama serve";
        Restart = "on-failure";
        # Optional: set environment, working dir, etc.
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
