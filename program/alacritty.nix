{ lib, config, pkgs, ... }:
with
lib;
let
  cfg    = config.kirby.program.alacritty;
  colors = {
    dark = {
      primary = {
        background = "0x1C1C1C";
        foreground  = "0xffffff";
      };

      cursor = {
        text = "0x2E3440";
        cursor = "0xcf7680";
      };

      normal = {
        black = "0x3B4252";
        red = "0xBF616A";
        green = "0xA3BE8C";
        yellow = "0xEBCB8B";
        blue = "0x81A1C1";
        magenta = "0xB48EAD";
        cyan = "0x88C0D0";
        white = "0xffffff";
      };

      bright = {
        black = "0x4C566A";
        red = "0xBF616A";
        green = "0xA3BE8C";
        yellow = "0xEBCB8B";
        blue = "0x81A1C1";
        magenta = "0xB48EAD";
        cyan = "0x8FBCBB";
        white = "0xffffff";
      };
    };

    bright = {
      primary = {
        background = "0xF5F5F5"; # white background
        foreground = "0x2E3440"; # dark text
      };

      cursor = {
        text = "0xFFFFFF";
        cursor = "0xCF7680";
      };

      normal = {
        black   = "0xD8DEE9"; # light grey
        red     = "0xBF616A"; # soft red
        green   = "0x88A46F"; # soft green
        yellow  = "0xC4A000"; # muted orange
        blue    = "0x4C6E91"; # soft blue
        magenta = "0xB48EAD"; # soft purple
        cyan    = "0x3A9FBF"; # soft cyan
        white   = "0x2E3440"; # dark for light themes
      };

      bright = {
        black   = "0xD8DEE9";
        red     = "0xD57780";
        green   = "0xB4D087";
        yellow  = "0xC4A000";
        blue    = "0x4C6E91";
        magenta = "0xC895BF";
        cyan    = "0x2E8B94";
        white   = "0x000000";
      };
    };
  };

  systemScale  = 1.5;
  baseFontSize = 25;
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
        package = pkgs.alacritty-graphics;
        settings = lib.attrsets.recursiveUpdate
        {
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
            offset.x = 0;
            size = baseFontSize / systemScale;
            normal.family = "PxPlus IBM VGA 9x16";
            normal.style = "Regular";

            bold.family = "PxPlus IBM VGA 9x16";
            bold.style = "Regular";

            italic.family = "PxPlus IBM VGA 9x16";
            italic.style = "Regular";


            # normal.family = "APL386 Unicode";
            # bold.family = "APL386 Unicode";
            # italic.family = "APL386 Unicode";
          };

          cursor.style = "Beam";

          terminal.shell = {
            program = "fish";
          };

          colors =
            if cfg.colorMode == "dark"
            then colors.dark
            else colors.bright;
          }
          cfg.settingOverrides;
        };
      };
    }
