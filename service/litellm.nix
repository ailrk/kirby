{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.service.litellm;

  litellmConfigFile = pkgs.writeText "litellm-config.yaml" /* yaml */ ''
    model_list:
      - model_name: github-copilot-model
        litellm_params:
          model: ${cfg.model}
          api_key: "os.environ/OPENROUTER_API_KEY"
          drop_params: true

    litellm_settings:
      drop_params: true
      set_verbose: false
  '';
in
{
  options.kirby.service.litellm = {
    enable = mkEnableOption "Enable LiteLLM Bridge";
    model = mkOption {
      type = types.str;
      default = "openrouter/qwen/qwen-2.5-coder-32b";
    };
    port = mkOption {
      type = types.str;
      default = "11435";
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

        # Best practice: Load the key from a file outside the Nix store
        # Replace "/home/youruser/.keys/openrouter.txt" with your actual path
        Environment = [
          "OPENROUTER_API_KEY=${builtins.readFile "~/.keys/openrouter"}"
        ];
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
