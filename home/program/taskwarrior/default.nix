{ config, lib, pkgs, ... }:
let
  cfg = config.kirby.home.program.taskwarrior;
in
{
  options.kirby.home.program.taskwarrior = {
    enable = lib.mkEnableOption "Enable taskwarrior";
  };
  config = lib.mkIf cfg.enable {
    programs.taskwarrior = {
      enable = true;
    };

    home.file.".taskrc".source = ./taskrc;
  };
}
