{ config, lib, pkgs, ... }:
with lib;
let

  cfg = config.elemental.home.program.shell.fish;
in
{
  options.elemental.home.program.shell.fish = {
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

      promptInit = ''
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
