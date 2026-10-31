{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.ranger;
in
{
  options.kirby.program.ranger = {
    enable = mkEnableOption "Enable to ranger file manager";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.ranger ];
    xdg.configFile."ranger/rc.conf".source = ./rc.conf;
    xdg.configFile."ranger/rifle.conf".source = ./rifle.conf;
    xdg.configFile."ranger/scope.sh".source = ./scope.sh;
  };
}
