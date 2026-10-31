{ config, lib, pkgs, ... }:
let
  cfg = config.kirby.program.zsh;
in
{
  options.kirby.program.zsh = {
    enable = lib.mkEnableOption "Enable zsh";
  };
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      initContent = ''
        any-nix-shell zsh --info-right | source /dev/stdin
      '';
    };
  };
}
