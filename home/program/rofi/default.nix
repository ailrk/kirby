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

      home.file.".fonts/Comfortaa/".source = ./fonts/Comfortaa;
      home.file.".fonts/fontsNoto_Sans/".source = ./fonts/Noto_Sans;
      home.file.".fonts/Fantasque-Sans-Mono-Nerd-Font.ttf".source = ./fonts/Fantasque-Sans-Mono-Nerd-Font.ttf;
      home.file.".fonts/Feather.ttf".source = ./fonts/Feather.ttf;
      home.file.".fonts/Hurmit-Nerd-Font-Mono.otf".source = ./fonts/Hurmit-Nerd-Font-Mono.otf;
      home.file.".fonts/Iosevka-Nerd-Font.ttf".source = ./fonts/Iosevka-Nerd-Font.ttf;
  };
}
