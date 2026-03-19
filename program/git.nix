{ config, lib, ... }:
let
  cfg = config.kirby.program.git;
in
{
  options.kirby.program.git = {
    enable = lib.mkEnableOption "Enable git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "jimmy123good@gmail.com";
          name = "Ailrk";
        };
        alias = {
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
      signing = {
        signByDefault = true;
        key = "~/.ssh/id_ed25519";
        format = "ssh";
      };
    };
  };
}
