{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.rofi;
  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
in
  {
  options.kirby.program.rofi = {
    enable = mkEnableOption "Enable rofi application launcher";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.rofi ];

    xdg.configFile =
      let
        scripts = mapAttrs' (fileName: _: nameValuePair "scripts/${fileName}"
          { source = symlink "${home}/kirby/program/rofi/scripts/${fileName}"; })
          (builtins.readDir ./scripts);
        themes = {
          "rofi/theme".source = symlink "${home}/kirby/program/rofi/theme";
          "rofi/styels".source = symlink "${home}/kirby/program/rofi/styles";
        };
      in themes // scripts;

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
