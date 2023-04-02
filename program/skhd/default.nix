{ config, lib, pkgs, ...}:
with
lib;
let
  cfg = config.kirby.program.skhd;
in
{
  options.kirby.program.skhd = {
    enable = mkEnableOption "Enable skhd in darwin";
  };

  config = mkIf (cfg.enable && builtins.currentSystem == "aarch64-darwin")   {
    home.packages = with pkgs; [
      skhd
    ];

    xdg.configFile = {
      "skhd/skhdrc" = {
        source = ./skhdrc;
        executable = true;
      };
    };
  };
}
