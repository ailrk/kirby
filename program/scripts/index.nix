{ config, lib, ... }:
with
lib;
let
  cfg = config.kirby.program.scripts;

  scripts = {
    "brightness" = ./brightness;
    "screenshot" = ./screenshot;
    "volume" = ./volume;
    "unnix" = ./unnix;
    "colormode" = ./colormode;
    "rebuildhm" = ./rebuildhm;
  };

in
{
  options.kirby.program.scripts = {
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
      (scripts // cfg.scriptFiles);
  };
}
