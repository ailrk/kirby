# fatmonad
{ config, lib, pkgs, ... }:
with lib;
{
  imports = [
    ../program/linux.nix
    ../service/default.nix
  ];

  options.kirby.home.linux_x86.fatmonad = {
    enable  = mkEnableOption "Set user as a fatmonad";
  };

  config = mkIf config.kirby.home.linux_x86.fatmonad.enable {
    home.stateVersion = "24.11";
    home.username = "fatmonad";
    home.homeDirectory = "/home/fatmonad";
    programs.home-manager.enable = true;
    manual.manpages.enable = false;

    kirby = {
      program = {
        git.enable = true;
        neovim = {
          enable = true;
          nightly = false;
        };
        ranger.enable = true;
        tmux.enable = true;
        bspwm.enable = true;
        compton.enable = true;
        polybar.enable = true;
        sxhkd.enable = true;
        dunst.enable = true;
        alacritty.enable = true;
        scripts.enable = true;
        xconfig.enable = true;
        rofi.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
        newsflash.enable = true;
      };

      service = {
        ollama.enable = true;
      };
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

    # Install packages
    home = {
      packages = [
          pkgs.libGL
          pkgs.racket
          pkgs.dotnet-sdk
          pkgs.purescript

          # gui
          pkgs.google-chrome
          pkgs.muse
          pkgs.blender
          pkgs.tdesktop
          pkgs.discord
          pkgs.aseprite
        ] ++ pkgs.callPackage ../packages.nix {};


      file = {
        ".xinitrc" = {
          executable = true;
          text = builtins.readFile ./.xinitrc;
        };

        ".xsession" = {
          executable = true;
          text = builtins.readFile ./.xsession;
        };

        ".xprofile" = {
          executable = true;
          text = builtins.readFile ./.xprofile;
        };

        ".profile" = {
          executable = true;
          text = builtins.readFile ./.profile;
        };

        ".Xresources" = {
          executable = true;
          text = builtins.readFile ./.Xresources;
        };
      };

      # Environment
      sessionVariables = {
        KIRBY_NIXGL = "nixGL";
        EDITOR = "nvim";
        BROWSER = "google-chrome-stable --force-device-scale-factor=1.5";
        TERMINAL = "$KIRBY_NIXGL alacritty";
        FILES = "nautilus";
      };
    };

    xdg.configFile = {
      "bspwm/bspwmrc" = {
          source = ./bspwmrc;
          executable = true;
      };
    };

    # User specific overlays.
    nixpkgs.overlays = [
      # discord
      (self: super: {
        discord = super.discord.overrideAttrs (_: {
          src = builtins.fetchTarball https://discord.com/api/download?platform=linux&format=tar.gz;
        });
      })
    ];
  };
}
