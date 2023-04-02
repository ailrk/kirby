{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.sxhkd;
in
{
  options.kirby.program.sxhkd = {
    enable = mkEnableOption "Enable sxhkd";
  };

  config = {
    home.packages = with pkgs; [
      sxhkd
    ];

    xdg.configFile."sxhkd/sxhkdrc" = {
        source = ./sxhkdrc;
        executable = true;
    };
  };
}
