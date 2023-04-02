{ config, lib, pkgs, ...}:
with
lib;
let
  cfg = config.kirby.program.yabai;
in
{
  options.kirby.program.yabai = {
    enable = mkEnableOption "Enable yabai window manager in darwin";
  };

  config = mkIf (cfg.enable && builtins.currentSystem == "aarch64-darwin")   {
    home.packages = with pkgs; [
      yabai
    ];

    xdg.configFile = {
      "yabai/yabairc" = {
        source = ./yabairc;
        executable = true;
      };
    };
  };
}
