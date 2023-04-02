{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.kitty;
in
{
  options.kirby.program.kitty = {
    enable = mkEnableOption "Enable the kitty terminal";

    settingOverrides = mkOption {
      type = types.attrs;
      default = { };
      description = "Override the kirby default config";
    };

  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "iosevka";
        size = 12;
      };
    };
  };
}
