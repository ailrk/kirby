{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.ranger;
  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
in
{
  options.kirby.program.ranger = {
    enable = mkEnableOption "Enable to ranger file manager";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.ranger ];

    xdg.configFile."ranger/rc.conf".source =
      symlink "${home}/kirby/program/ranger/rc.conf";

    xdg.configFile."ranger/rifle.conf".source =
      symlink "${home}/kirby/program/ranger/rifle.conf";

    xdg.configFile."ranger/scope.sh".source =
      symlink "${home}/kirby/program/ranger/scope.sh";
  };
}
