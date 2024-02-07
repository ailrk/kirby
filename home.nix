{ config, pkgs, lib, ... }:

{
  imports = [
    ./program/default.nix
    ./service/default.nix
    ./user/default.nix
  ];

  home.username = "fatmonad";
  home.homeDirectory = "/home/fatmonad";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  manual.manpages.enable = false;

  # 
  # kirby configuration. You can pick any machine and 
  # user config as long as their configurations don't
  # conflict
  #
  kirby = {
    user.programmer.enable = true;

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

      bspwm.enable = true;
      compton.enable = true;
      polybar.enable = true;
      dunst.enable = true;
      sxhkd.enable = true;
      alacritty.enable = true;
      scripts.enable = true;
      xconfig.enable = true;
      rofi = {
        enable = true;
        resolution = "720p";
      };
    };

    service = {
      dropbox.enable = true;
    };
  };


  services.gpg-agent = {
   enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; with pkgs.fcitx5; [ fcitx5-rime fcitx5-mozc fcitx5-gtk fcitx5-chinese-addons ];
  };

  fonts.fontconfig.enable = true;
}
