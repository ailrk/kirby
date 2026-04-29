{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.service.litellm;

  litellmConfigFile = pkgs.writeText "litellm-config.yaml" /* yaml */ ''
    model_list:
      - model_name: copilot-model
        litellm_params:
          model: ${cfg.instances.copilot.model}
          api_key: ${cfg.instances.copilot.apiKey}
          max_tokens: 4096
          drop_params: true

    litellm_settings:
      drop_params: true
      set_verbose: false
  '';
in
  {
    options.kirby.service.litellm = {
      port = mkOption {
        type = types.str;
        default = "11435";
        description = "The port for LiteLLM service";
      };

      enable = mkEnableOption "Enable LiteLLM service";

      instances = mkOption {
        type = types.attrsOf (types.submodule {
          options = {
            model = mkOption { type = types.str; default = "no-model"; };
            apiKey = mkOption { type = types.str; default = "no-key"; };
          };
        });
        default = {};
      };
    };
  config = mkIf cfg.enable {
    home.packages = [ pkgs.litellm ];

    systemd.user.services.litellm = {
      Unit = {
        Description = "LiteLLM Proxy Bridge for Copilot";
        After = [ "network.target" ];
      };
      Service = {
        ExecStart = "${pkgs.litellm}/bin/litellm --config ${litellmConfigFile} --port ${cfg.port}";
        Restart = "on-failure";
        EnvironmentFile = config.sops.templates."litellm-env".path;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
