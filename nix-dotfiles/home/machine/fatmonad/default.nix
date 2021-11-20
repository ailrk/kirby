{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.elemental.home.machine.fatmonad;
in
{
  options.elemental.home.machine.boron = {
    enable = mkEnableOption "Enable the fatmonad machine specific configuration";
  };

  config = mkIf (config.elemental.machine == "fatmonad") {
    # elemental.home.program.admin.restic.includeDir = ./restic/includes;
    # elemental.home.program.admin.restic.excludeDir = ./restic/excludes;

    # elemental.home.program.admin.restic = {
    #   enable = true;
    #   enableFishScripts = true;
    #   enableBackScript = true;
    # };
  };
}
