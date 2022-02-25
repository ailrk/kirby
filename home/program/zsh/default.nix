{ config, lib, pkgs, ... }:
let
  cfg = config.kirby.home.program.shell.zsh;
in
{
  options.kirby.home.program.shell.zsh = {
    enable = lib.mkEnableOption "Enable zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
    };
  };
}
