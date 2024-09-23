{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.program.git;
in
{
  options.kirby.program.git = {
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
      extraConfig = {
        diff = {
          tool = "vimdiff";
        };
      } // cfg.extraConfig;
      aliases = {
        "s" = "status";
        "ch" = "checkout";
        "br" = "branch";
        "d" = "diff";
        "ds" = "diff --stat";
        "dw" = "diff --color-words";
        "dn" = "diff --name-only";
        "f" = "fetch";
        # Commits, additions, and modifications
        "c" = "commit";
        "a" = "add";
        # Logging
        "lgo" = "log --oneline --graph";
        "lo" = "log --oneline";
        "ln" = "log -n"; # follow with a number to show n logs
        "lon" = "log --oneline -n"; # follow with a number to show n logs
      };
    };
  };
}
