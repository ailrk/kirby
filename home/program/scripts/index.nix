{ config, lib, ... }:
with
lib;
let
  cfg = config.kirby.home.program.scripts;

  scripts = {
    "brightness" = ./misc/brightness;
    "build-folders" = ./misc/build-folders;
    "mknsh" = ./misc/mknsh;
    "mpc-song" = ./misc/mpc-song;
    "newnote" = ./misc/newnote;
    "redshift-toggle" = ./misc/redshift-toggle;
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
    "rofio" = ./misc/rofio;
    "bin" = ./misc/bin;
  };

  static = {
    "static" = ./static;
  };
in
{
  options.kirby.home.program.scripts = {
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
