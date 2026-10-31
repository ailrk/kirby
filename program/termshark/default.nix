{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.termshark;
  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
in
{

  options.kirby.program.termshark = {
    enable = mkEnableOption "Enable termshark ";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      termshark
      tshark
    ];

    xdg.configFile = {
      "termshark/termshark.toml".source =
        symlink "${home}/kirby/program/termshark/termshark.toml";
    };
  };
}
