{ lib, config, ... }:
with
lib;
let
  cfg = config.kirby.program.alacritty;
  colors = import ./colors.nix;

in
{
  options.kirby.program.alacritty = {
    enable = mkEnableOption "Enable the alacritty terminal";

    settingOverrides = mkOption {
      type = types.attrs;
      default = { };
      description = "Override the kirby default config";
    };

    colorMode = mkOption {
      type = types.enum ["dark" "light"];
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
            opacity = 0.97;
            decorations = "none";
          };

          font = {
            offset.x = -1;
            size = 20;
            normal.family = "APL386 Unicode";
            bold.family = "APL386 Unicode";
            italic.family = "APL386 Unicode";
          };

          cursor.style = "Beam";

          terminal.shell = {
            program = "fish";
          };

          colors =
            if cfg.colorMode == "dark"
            then colors.dark
            else colors.bright;
        })
        cfg.settingOverrides;
    };
  };
}
