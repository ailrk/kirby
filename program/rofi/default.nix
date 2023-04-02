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

      home.file.".fonts/Comfortaa/".source = ./fonts/Comfortaa;
      home.file.".fonts/fontsNoto_Sans/".source = ./fonts/Noto_Sans;
      home.file.".fonts/Fantasque-Sans-Mono-Nerd-Font.ttf".source = ./fonts/Fantasque-Sans-Mono-Nerd-Font.ttf;
      home.file.".fonts/Feather.ttf".source = ./fonts/Feather.ttf;
      home.file.".fonts/Hurmit-Nerd-Font-Mono.otf".source = ./fonts/Hurmit-Nerd-Font-Mono.otf;
      home.file.".fonts/Iosevka-Nerd-Font.ttf".source = ./fonts/Iosevka-Nerd-Font.ttf;

      home.file.".fonts/Code-New-Roman-b.woff".source = ./fonts/Code-New-Roman-b.woff;
      home.file.".fonts/Code-New-Roman-i.woff".source = ./fonts/Code-New-Roman-i.woff;
      home.file.".fonts/Code-New-Roman.woff".source = ./fonts/Code-New-Roman.woff;
  };
}
