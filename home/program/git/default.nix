{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.home.program.git;
in
{
  options.kirby.home.program.git = {
    enable = lib.mkEnableOption "Enable git";

    userEmail = lib.mkOption {
      type = types.lines;
      description = "The git config email";
      default = "";
    };

    userName = lib.mkOption {
      type = types.lines;
      description = "The git config name";
      default = "";
    };

    signByDefault = lib.mkOption {
      type = types.bool;
      description = "Whether to gpg sign by default";
      default = false;
    };
    
    signKey = lib.mkOption {
      type = types.lines;
      description = "The gpg-signing key";
      default = "";
    };

    extraConfig = lib.mkOption {
      description = "Extra git config";
      default = {
        # Pull behaviour
        pull.rebase = false;
      };
    };

    delta.enable = lib.mkOption {
      type = types.bool;
      description = "Use Delta for diff viewing";
      default = false;
    };

  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userEmail = cfg.userEmail;
      userName = cfg.userName;
      signing.signByDefault = cfg.signByDefault;
      signing.key = cfg.signKey;
      extraConfig = cfg.extraConfig;
      aliases = {
        "s" = "status";
        "co" = "checkout";
        "br" = "branch";
        # Commits, additions, and modifications
        "cm" = "commit -m";
        "aa" = "add .";
        "rh" = "reset --hard";
        # Logging
        "lgo" = "log --oneline --graph";
        "lo" = "log --oneline";
        "ln" = "log -n"; # follow with a number to show n logs
        "lon" = "log --oneline -n"; # follow with a number to show n logs
      };
    };
  };
}
