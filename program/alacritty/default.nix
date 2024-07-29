{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.alacritty;
in
{
  options.kirby.program.alacritty = {
    enable = mkEnableOption "Enable the alacritty terminal";

    settingOverrides = mkOption {
      type = types.attrs;
      default = { };
      description = "Override the kirby default config";
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = lib.attrsets.recursiveUpdate
        ({
          env = {
            "TERM" = "xterm-256color";
            "WINIT_X11_SCALE_FACTOR"=  "1.0";
          };

          window = {
            padding.x = 10;
            padding.y = 11;
            opacity = 0.96;
            decorations = "none";
          };

          font = {
            size = 18;
            normal.family = "Code New Roman";
            bold.family = "Code New Roman";
            italic.family = "Code New Roman";
          };

          cursor.style = "Beam";

          shell = {
            program = "fish";
          };

          colors = (import ./colors.nix).dark;
        })
        cfg.settingOverrides;
    };
  };
}
