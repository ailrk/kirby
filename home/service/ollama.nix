{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.service.ollama;
  # you can't inline multiple environment variables, just use a file here.
  envFileAMDRTX6600 = pkgs.writeTextFile {
    name = "ollama-env-vars.env";
    text = ''
      HSA_OVERRIDE_GFX_VERSION=10.3.0
      ROCM_PATH=/opt/rocm
    '';
  };

  ollama =
    if cfg.amd
      then pkgs.ollama-rocm
      else pkgs.ollama;
in
{

  options.kirby.service.ollama = {
    enable = mkEnableOption "Enable ollama";
    amd = mkEnableOption "Use amd GPU";
  };


  config = mkIf cfg.enable {
    # Add Ollama to your profile
    home.packages = [ ollama ];

    # Define a user-level systemd service
    systemd.user.services.ollama = {
      Unit = {
        Description = "Ollama API server";
        After = [ "network.target" ];
      };
      Service = {
        ExecStart = "${ollama}/bin/ollama serve";
        Restart = "on-failure";
        EnvironmentFile = envFileAMDRTX6600;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
