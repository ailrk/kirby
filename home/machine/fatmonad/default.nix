{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.home.machine.fatmonad;
in
{
  options.kirby.home.machine.boron = {
    enable = mkEnableOption "Enable the fatmonad machine specific configuration";
  };

  config = mkIf (config.kirby.machine == "fatmonad") {
    # kirby.home.program.admin.restic.includeDir = ./restic/includes;
    # kirby.home.program.admin.restic.excludeDir = ./restic/excludes;

    # kirby.home.program.admin.restic = {
    #   enable = true;
    #   enableFishScripts = true;
    #   enableBackScript = true;
    # };
  };
}
