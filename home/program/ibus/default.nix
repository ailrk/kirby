{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.home.program.ibus;
in
{
  options.kirby.home.program.ibus = {
    enable = lib.mkEnableOption "Enable ibus";

    ibusEngines = lib.mkOption {
      type = types.listOf ;
      description = "ibus engines";
      default = [ libpinyin ];
    };
  }

  config = lib.mkIf cfg.enable {
    programs.ibus = {
      enbale = true;
    }
  }
}
