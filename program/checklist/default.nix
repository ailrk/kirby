{ lib, config, ... }:
with
lib;
let
  cfg = config.kirby.program.checklist;
in
{
  options.kirby.program.cbb = {
    enable = mkEnableOption "Enable checklist";
  };

  config = mkIf cfg.enable {
    xdg.configFile."checklist/checklist".source = ./checklist;
    xdg.configFile."performance.cl".source = ./performance.cl;
  };
}
