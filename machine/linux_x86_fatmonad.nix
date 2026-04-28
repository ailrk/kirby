# fatmonad
{ config, lib, pkgs, inputs, ... }:
with lib;
let
  cfg   = config.kirby.home.linux_x86.fatmonad;
  NIXGL = "nixGLIntel";
in
{
  imports = [
    ../program/default.nix
    ../service/default.nix
    ./linux.nix
  ];

  options.kirby.home.linux_x86.fatmonad = {
    enable = mkEnableOption "Set user as a fatmonad";
    colorMode = mkOption {
      type = types.enum ["dark" "light"];
      default = "light";
      description = "color mode of the system";
    };
  };

  config = mkIf config.kirby.home.linux_x86.fatmonad.enable {
    home.stateVersion = "25.11";
    home.username = "fatmonad";
    home.homeDirectory = "/home/fatmonad";
    manual.manpages.enable = false;
    programs = {
      home-manager.enable = true;
    };

    sops = {
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      defaultSopsFile = ../secrets/secret.yaml;
      secrets = {
         OPENROUTER_API_KEY = {};
      };
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
        ollama = {
          enable = true;
          amd = true;
        };
        litellm = {
          enable = true;
          model = "openrouter/qwen/qwen-2.5-coder-32b";
        };
      };

      linux.enable = true;
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

    # Install packages
    home = {
      packages = [
        inputs.nixgl.packages.${pkgs.system}.nixVulkanIntel
        inputs.nixgl.packages.${pkgs.system}.nixGLIntel
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
      ] ++ pkgs.callPackage ../packages.nix {};


      # Environment
      sessionVariables = {
        WSTART             = "${NIXGL} labwc";
        NIX_PATH           = "$HOME/.nix-defexpr/channels";
        NIXGL              = "${NIXGL}";
        EDITOR             = "nvim";
        BROWSER            = "google-chrome-stable";
        TERMINAL           = "alacritty";
        FILES              = "nautilus";
      };
    };
  };
}
