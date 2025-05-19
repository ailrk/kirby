# ailrk-asahi
{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.home.linux_m1.ailrk_asahi;
in
{
  imports = [
    ../../program/linux.nix
    ../../service/default.nix
  ];

  options.kirby.home.linux_m1.ailrk_asahi = {
    enable  = mkEnableOption "Set user as a ailrk-asahi";
    colorMode = mkOption {
      type = types.enum ["dark" "light"];
      default = "dark";
      description = "color mode of the system";
    };
  };

  config = mkIf config.kirby.home.linux_m1.ailrk_asahi.enable {
    home.stateVersion = "24.05";
    home.username = "ailrk-asahi";
    home.homeDirectory = "/home/ailrk-asahi";
    programs = {
      home-manager.enable = true;
    };

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
        sxhkd.enable = true;
        dunst.enable = true;
        alacritty = {
          enable = true;
          colorMode = cfg.colorMode;
        };
        polybar = {
          enable = true;
          colorMode = cfg.colorMode;
        };
        scripts.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
        newsflash.enable = true;
        xconfig.enable = true;
        rofi.enable = true;
      };
      service = {
        ollama.enable = true;
      };
    };

    # Install packages
    home.packages = [
          (with import <nixgl> { enable32bits = false; }; nixGLMesa)
          # libraries
          pkgs.libGL
          pkgs.libgcc
          pkgs.gtk4
          pkgs.xdg-desktop-portal
          pkgs.chromium
        ] ++ pkgs.callPackage ../../packages.nix {};


    home.file = {
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

    xdg.configFile = {
      "nix/nix.conf".source = ./nix.conf;

      "bspwm/bspwmrc" = {
          source = ./bspwmrc;
          executable = true;
      };
    };

    # Environment
    home.sessionVariables = {
      KIRBY_NIXGL = "nixGLMesa";
      EDITOR = "nvim";
      BROWSER = "chromium --force-device-scale-factor=1.5";
      TERMINAL = "nixGLMesa alacritty";
      FILES = "nautilus";
      EMAIL_CLIENT = "thunderbird";
      BATTERY = "macsmc-battery";
      BATTERY_ADAPTOR = "macsmc-ac";
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
