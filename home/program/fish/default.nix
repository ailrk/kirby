{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.home.program.fish;
in
{
  options.kirby.home.program.fish = {
    enable = lib.mkEnableOption "Enable fish";

    preShellInit = mkOption {
      type = types.lines;
      default = "";
      description = "Prepend to the shell init script";
    };
  };

  config = mkIf cfg.enable {

    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        any-nix-shell fish --info-right | source
      '';

      shellInit = cfg.preShellInit + ''
        source $HOME/.config/fish/fish-config.fish
      '';
    };

    xdg.configFile = {
      "fish/fish-config.fish" = {
        source = ./fish-config.fish;
      };
    };
  };
}
