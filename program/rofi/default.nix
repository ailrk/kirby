{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.rofi;
  link = config.lib.file.mkOutOfStoreSymlink;
in
  {
  options.kirby.program.rofi = {
    enable = mkEnableOption "Enable rofi application launcher";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.rofi ];
    xdg.configFile."rofi/theme".source = ./theme;
    xdg.configFile."rofi/styles".source = ./styles;

    # link binaries to scripts
    xdg.configFile."scripts/launcher".source = link ./scripts/launcher;
    xdg.configFile."scripts/screenshot".source = link ./scripts/screenshot;
    xdg.configFile."scripts/quickaccess".source = link ./scripts/quickaccess;
    xdg.configFile."scripts/videorecording".source = link ./scripts/videorecording;
    xdg.configFile."scripts/powermenu".source = link ./scripts/powermenu;

    xdg.desktopEntries = {
      screenshot = {
        name = "Screenshot Tool";
        exec = "${config.xdg.configHome}/scripts/screenshot";
        icon = "camera-photo";
        type = "Application";
      };
    };
    xdg.desktopEntries = {
      videorecording = {
        name = "Video recording Tool";
        exec = "${config.xdg.configHome}/scripts/videorecording";
        icon = "camera-photo";
        type = "Application";
      };
    };
  };
}
