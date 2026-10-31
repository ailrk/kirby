{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.waybar;
  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
in
{
  options.kirby.program.waybar = {
    enable = mkEnableOption "Enable waybar";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      waybar
    ];

    xdg.configFile."waybar/config".source =
      symlink "${home}/program/waybar/config";

    xdg.configFile."waybar/style.css".source =
      symlink "${home}/program/waybar/style.css";

    xdg.configFile."waybar/battery.sh".source =
      symlink "${home}/program/waybar/battery.sh";

    xdg.configFile."waybar/im.sh".source =
      symlink "${home}/program/waybar/im.sh";
  };
}
