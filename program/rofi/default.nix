{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.rofi;
in
{
  options.kirby.program.rofi = {
    enable = mkEnableOption "Enable rofi application launcher";

    resolution = mkOption {
      type = types.str;
      description = "The resolution for rofi menu";
    };
  };

  config = mkIf cfg.enable {
      home.packages = [ pkgs.rofi ];
      xdg.configFile."rofi/".source = ./${cfg.resolution};

      home.file.".fonts/Feather.ttf".source = ./fonts/Feather.ttf;
  };
}
