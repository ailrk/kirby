{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.program.fish;
in
{
  options.kirby.program.fish = {
    enable = lib.mkEnableOption "Enable fish shell";

    preShellInit = mkOption {
      type = types.lines;
      default = "";
      description = "Prepend to the shell init script";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fishPlugins.bass
    ];

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
