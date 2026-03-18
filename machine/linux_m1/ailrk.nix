# ailrk
{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.kirby.home.linux_m1.ailrk;
in
{
  imports = [
    ../../program/linux.nix
    ../../service/default.nix
  ];

  options.kirby.home.linux_m1.ailrk= {
    enable  = mkEnableOption "Set user as a ailrk";
    colorMode = mkOption {
      type = types.enum ["dark" "light"];
      default = "dark";
      description = "color mode of the system";
    };
  };

  config = mkIf config.kirby.home.linux_m1.ailrk.enable {
    home.stateVersion = "25.11";
    home.username = "ailrk";
    home.homeDirectory = "/home/ailrk";
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
        labwc.enable = true;
        waybar.enable = true;
        compton.enable = true;
        dunst.enable = true;
        alacritty = {
          enable = true;
          colorMode = cfg.colorMode;
        };
        scripts.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
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
          pkgs.chromium
          pkgs.aseprite
          pkgs.tiled
        ] ++ pkgs.callPackage ../../packages.nix {};


    xdg.configFile = {
      "nix/nix.conf".source = ./nix.conf;
    };

    # Environment
    home.sessionVariables = {
      GUI             = "NIX_REMOTE=daemon labwc";
      NIX_PATH        = "$HOME/.nix-defexpr/channels";
      NIX_REMOTE      = "daemon";
      NIXGL           = "nixGLMesa";
      EDITOR          = "nvim";
      BROWSER         = "$NIXGL chromium";
      TERMINAL        = "$NIXGL alacritty";
      FILES           = "$NIXGL nautilus";
      BATTERY         = "macsmc-battery";
      BATTERY_ADAPTOR = "macsmc-ac";
    };

    nixpkgs.config = {
      allowUnfree = true;
      pulseaudio = true;
    };

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; with pkgs.fcitx5; [ fcitx5-rime fcitx5-mozc fcitx5-gtk qt6Packages.fcitx5-chinese-addons ];
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
