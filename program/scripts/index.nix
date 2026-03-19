{ config, lib, ... }:
with
lib;
let
  cfg = config.kirby.program.scripts;

  scripts = {
    "brightness" = ./brightness;
    "sshot" = ./sshot;
    "volume" = ./volume;
    "unnix" = ./unnix;
    "colormode" = ./colormode;
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

      xdg.desktopEntries= {
        sshot = {
          name = "Screenshot Tool";
          exec = "${config.xdg.configHome}/scripts/sshot sel"; # Default action
          icon = "camera-photo";
          type = "Application";
          actions = {
            "Full" = {
              name = "Screenshot Full Screen";
              exec = "${config.xdg.configHome}/scripts/sshot full";
            };
            "Window" = {
              name = "Screenshot Window";
              exec = "${config.xdg.configHome}/scripts/sshot win";
            };
          };
        };

        volume-control = {
          name = "Volume Toggle Mute";
          exec = "${config.xdg.configHome}/scripts/volume mute";
          icon = "audio-volume-high";
          terminal = false;
          categories = [ "Settings" ];
          actions = {
            "Up" = { name = "Volume +5%"; exec = "${config.xdg.configHome}/scripts/volume up"; };
            "Down" = { name = "Volume -5%"; exec = "${config.xdg.configHome}/scripts/volume down"; };
          };
        };

        brightness-control = {
          name = "Brightness Max";
          exec = "brightnessctl set 100%%";
          icon = "display-brightnesssymbolic";
          terminal = false;
          categories = [ "Settings" ];
          actions = {
            "Increase" = { name = "Brightness +10%"; exec = "${config.xdg.configHome}/scripts/brightness up"; };
            "Decrease" = { name = "Brightness -10%"; exec = "${config.xdg.configHome}/scripts/brightness down"; };
          };
        };

      };
    };
  }
