{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.home.program.rofi;
in
{
  options.kirby.home.program.rofi = {
    enable = mkEnableOption "Enable to tmux terminal multiplexer";

    resolution = mkOption {
      type = types.str;
      description = "The resolution for rofi menu";
    };
  };

  config = mkIf cfg.enable {
      home.packages = [ pkgs.rofi ];
      xdg.configFile."rofi/".source = ./${cfg.resolution};

      xdg.dataFile."Comfortaa/".source = ./fonts/Comfortaa;
      xdg.dataFile."Noto_Sans/".source = ./fonts/Noto_Sans;
      xdg.dataFile."Fantasque-Sans-Mono-Nerd-Font.ttf".source = ./fonts/Fantasque-Sans-Mono-Nerd-Font.ttf;
      xdg.dataFile."Feather.ttf".source = ./fonts/Feather.ttf;
      xdg.dataFile."Hurmit-Nerd-Font-Mono.otf".source = ./fonts/Hurmit-Nerd-Font-Mono.otf;
      xdg.dataFile."Iosevka-Nerd-Font.ttf".source = ./fonts/Iosevka-Nerd-Font.ttf;
  };
}
