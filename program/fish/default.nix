{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.program.fish;
  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;

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

      functions = {
        fish_prompt = {
          body = ''
            set -l last_status $status

            echo -s (set_color cyan) "[" (date "+%H:%M") "]" (set_color normal) \
                   " " \
                   (set_color green) $USER (set_color normal) \
                   "@" \
                   (set_color yellow) $hostname (set_color normal) \
                   " " \
                   (set_color blue) (prompt_pwd) (set_color normal) \
                   (fish_git_prompt)

            echo -n -s "> "
          '';
        };
      };

      interactiveShellInit = ''
        # Git prompt status flags
        set -g __fish_git_prompt_showdirtystate 1
        set -g __fish_git_prompt_showuntrackedfiles 1
        set -g __fish_git_prompt_showcolorhints 1
        set -g __fish_git_prompt_showupstream "auto"

        any-nix-shell fish --info-right | source
      '';

      shellInit = cfg.preShellInit + ''
        source $HOME/.config/fish/fish-config.fish
      '';
    };

    xdg.configFile = {
      "fish/fish-config.fish" = {
        source = symlink "${home}/kirby/program/fish/fish-config.fish";
      };
    };
  };
}
