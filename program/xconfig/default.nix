{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.kirby.program.xconfig;
in
{ 
  options.kirby.program.xconfig = {
    enable = mkEnableOption "Enable extra xconfig files";
  };

  config = mkIf cfg.enable {
    xdg.configFile."gtk-3.0/settings.ini".source = ./gtk-3.0/settings.ini;
  };
}
