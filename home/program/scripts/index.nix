{ config, lib, ... }:
with
lib;
let
  cfg = config.elemental.home.program.scripts;

  scripts = {
    "brightness" = ./misc/brightness;
    "build-folders" = ./misc/build-folders;
    "mknsh" = ./misc/mknsh;
    "mpc-song" = ./misc/mpc-song;
    "newnote" = ./misc/newnote;
    "redshift-toggle" = ./misc/redshift-toggle;
    "rofio" = ./misc/rofio;
    "screenshot" = ./misc/screenshot;
    "switchwifi" = ./misc/switchwifi;
    "tmux-setup" = ./misc/tmux-setup;
    "tmux-vim" = ./misc/tmux-vim;
    "toggle-ibus" = ./misc/toggle-ibus;
    "toggle-Xcolor" = ./misc/toggle-Xcolor;
    "transparent" = ./misc/transparent;
    "vanela" = ./misc/vanela;
    "vdbconfig" = ./misc/vdbconfig;
    "volume" = ./misc/volume;
    "workplace" = ./misc/workplace;
    "xclips" = ./misc/xclips;
    "xlsjson" = ./misc/xlsjson;

    "bin" = ./misc/bin;
    "nix-zsh-completions" = ./misc/nix-zsh-completions;
    "smlformat" = ./misc/smlformat;
    "stark-Color-Scripts-299a816" = ./misc/stark-Color-Scripts-299a816;
    "zsh-nix-shell" = ./misc/zsh-nix-shell;
    "zgen.zsh" = ./misc/zgen.zsh;

  };

  static = {
    "static" = ./static;
  };
in
{
  options.elemental.home.program.scripts = {
    enable = mkEnableOption "Enable home scripts";

    scriptFiles = mkOption {
      type = types.attrsOf types.path;
      default = { };
      description = "Files to source into the scripts directory.";
    };

  };

  config = mkIf cfg.enable {

    # Map script files into the scripts directory
    xdg.configFile = mapAttrs'
      (n: v: nameValuePair "scripts/${n}" {
        source = v;
        executable = true;
      })
      (scripts // static // cfg.scriptFiles);
  };
}
