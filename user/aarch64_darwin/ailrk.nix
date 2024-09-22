# ailrk
{ config, lib, pkgs, ... }:
with lib;
{
  options.kirby.user.aarch64_darwin.ailrk = {
    enable = mkEnableOption "Set user as a ailrk";
  };

  config = mkIf config.kirby.user.aarch64_darwin.ailrk.enable {
    home.stateVersion = "23.11";
    home.username = "ailrk";
    home.homeDirectory = "/Users/ailrk";
    manual.manpages.enable = false;

    kirby = {
      program = {
        git = {
          enable = true;
          userEmail = "jimmy123good@gmail.com";
          userName = "Ailrk";
          signByDefault = true;
          signKey = "~/.ssh/id_rsa.pub";
          extraConfig = {
            gpg.format = "ssh";
          };
        };
        neovim = {
          enable = true;
          nightly = false;
        };
        ranger.enable = true;
        tmux.enable = true;
        bspwm.enable = true;
        alacritty.enable = true;
        scripts.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
      };
    };
  };
}
