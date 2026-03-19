# fatmonad
{ config, lib, pkgs, ... }:
with lib;
let
  cfg   = config.kirby.home.linux_x86.fatmonad;
  NIXGL = "nixGLIntel";
in
{
  imports = [
    ../../program/default.nix
    ../../service/default.nix
    ../linux.nix
  ];

  options.kirby.home.linux_x86.fatmonad = {
    enable = mkEnableOption "Set user as a fatmonad";
    colorMode = mkOption {
      type = types.enum ["dark" "light"];
      default = "dark";
      description = "color mode of the system";
    };
  };

  config = mkIf config.kirby.home.linux_x86.fatmonad.enable {
    home.stateVersion = "24.11";
    home.username = "fatmonad";
    home.homeDirectory = "/home/fatmonad";
    manual.manpages.enable = false;
    programs = {
      home-manager.enable = true;
    };

    kirby = {
      program = {
        git.enable = true;
        neovim = {
          enable = true;
          nightly = false;
        };
        ranger.enable = true;
        tmux.enable = true;
        labwc.enable = true;
        waybar.enable = true;
        dunst.enable = true;
        alacritty = {
          enable = true;
          colorMode = cfg.colorMode;
        };
        scripts.enable = true;
        rofi.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
        ueberzugpp.enable = true;
        fcitx5.enable = true;
      };

      service = {
        ollama.enable = true;
      };
    };

    nixpkgs.config = {
      allowUnfree = true;
      pulseaudio = true;
    };

    # Make sure check .local/share/applications/mimeinfo.cache
    # Sometimes gui program adds entries here and it overwrites
    # the default setting.
    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "x-scheme-handler/tg"="userapp-Telegram Desktop-5ZULP1.desktop";
        "application/pdf"="google-chrome.desktop";
        "image/gif"="google-chrome.desktop";
        "x-scheme-handler/file"="google-chrome.desktop";
      };

      associations.added = {
        "x-scheme-handler/tg"="userapp-Telegram Desktop-XX00J1.desktop;userapp-Telegram Desktop-5ZULP1.desktop;";
        "image/png"="google-chrome.desktop;";
        "image/jpeg"="google-chrome.desktop;";
        "application/pdf"="google-chrome.desktop;";
        "image/gif"="google-chrome.desktop;";
      };
    };

    fonts.fontconfig.enable = true;

    # Install packages
    home = {
      packages = [
        (with import <nixgl> { enable32bits = false; }; nixVulkanMesa)
        (with import <nixgl> { enable32bits = false; }; nixGLIntel)
        pkgs.libGL
        pkgs.racket
        pkgs.dotnet-sdk
        pkgs.purescript

          # gui
          pkgs.google-chrome
          pkgs.muse
          pkgs.blender
          pkgs.telegram-desktop
          pkgs.discord
          pkgs.aseprite
          pkgs.tiled
        ] ++ pkgs.callPackage ../../packages.nix {};


      # Environment
      sessionVariables = {
        WSTART  = "${NIXGL} labwc";
        NIX_PATH = "$HOME/.nix-defexpr/channels";
        NIXGL    = "${NIXGL}";
        EDITOR   = "nvim";
        BROWSER  = "google-chrome-stable";
        TERMINAL = "alacritty";
        FILES    = "nautilus";
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
