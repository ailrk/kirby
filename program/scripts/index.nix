{ config, lib, ... }:
with
lib;
let
  cfg = config.kirby.program.scripts;
  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
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
    xdg.configFile = mapAttrs' (fileName: _:
      nameValuePair "scripts/${fileName}" {
        source = symlink "${home}/kirby/program/scripts/src/${fileName}";
      }
    ) (builtins.readDir ./src);

  };
}
