{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.home.program.alacritty;
in
{
  options.kirby.home.program.alacritty = {
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
            opacity = 0.95;
            decorations = "none";
          };

          font = {
            size = 14;
            use_thin_strokes = true;
            normal.family = "Code New Roman";
            bold.family = "Code New Roman";
            italic.family = "Code New Roman";
          };

          cursor.style = "Beam";

          shell = {
            program = "fish";
            #args = [
            #"-C"
            #"/usr/bin/env neofetch"
            #];
          };

          # Nord
          colors = {
            # primary = {
            #   background = "#ffffff";
            #   foreground = "0x262424";
            # };

            primary = {
              background = "0x1A1819";
              foreground = "0xD8DEE9";
            };

            cursor = {
              text = "0x2E3440";
              cursor = "0xcf7680";
            };

# dark
            normal = {
              black = "0x3B4252";
              red = "0xBF616A";
              green = "0xA3BE8C";
              yellow = "0xEBCB8B";
              blue = "0x81A1C1";
              magenta = "0xB48EAD";
              cyan = "0x88C0D0";
              white = "0xE5E9F0";
            };

            bright = {
              black = "0x4C566A";
              red = "0xBF616A";
              green = "0xA3BE8C";
              yellow = "0xEBCB8B";
              blue = "0x81A1C1";
              magenta = "0xB48EAD";
              cyan = "0x8FBCBB";
              white = "0xECEFF4";
            };

# bright
            # normal = {
            #   black = "0x000000";
            #   red = "0xde3d35";
            #   green = "0x3e953a";
            #   yellow = "0xd2b67b";
            #   blue = "0x2f5af3";
            #   magenta = "0x950095";
            #   cyan = "0x3e953a";
            #   white = "0xbbbbbb";
            # };

            # bright = {
            #   black = "0x000000";
            #   red = "0xde3d35";
            #   green = "0x3e953a";
            #   yellow = "0xd2b67b";
            #   blue = "0x2f5af3";
            #   magenta = "0xa00095";
            #   cyan = "0x3e953a";
            #   white = "0xffffff";
            # };
          };
        })
        cfg.settingOverrides;
    };
  };
}
