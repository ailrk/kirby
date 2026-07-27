{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.cbb;
in
{

  options.kirby.program.cbb = {
    enable = mkEnableOption "Enable cbb - My command bible";
  };

  config = mkIf cfg.enable {
    xdg.configFile."scripts/cbb".source = ./cbb;
    xdg.configFile."cbb/cbb.yaml".source = ./cbb.yaml;
  };
}
