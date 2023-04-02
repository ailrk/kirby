{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.tmux;
in
{
  options.kirby.program.tmux = {
    enable = mkEnableOption "Enable to tmux terminal multiplexer";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.tmux ];
    xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  };
}
