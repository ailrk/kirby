{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.nmap;
  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
in
{
  options.kirby.program.nmap = {
    enable = mkEnableOption "Enable nmap";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.nmap ];
    xdg.configFile."nmap/scripts/vulners.nse".source =
      symlink "${home}/kirby/program/nmap/scripts/vulners.nse";
  };
}
