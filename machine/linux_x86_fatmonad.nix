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
          instances = {
            copilot = {
              model = "mistral/codestral-latest";
              apiKey = "os.environ/MISTRAL_API_KEY";
            };
          };
        };
      };

      linux.enable = true;
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
        pkgs.chromium
        pkgs.muse
        pkgs.blender
        pkgs.telegram-desktop
        pkgs.discord
        pkgs.aseprite
        pkgs.tiled

        pkgs.winetricks
        pkgs.wineWow64Packages.unstable
      ] ++ pkgs.callPackage ../packages.nix {};


      # Environment
      sessionVariables = {
        WSTART             = "${NIXGL} labwc";
        NIX_PATH           = "$HOME/.nix-defexpr/channels";
        NIXGL              = "${NIXGL}";
        EDITOR             = "nvim";
        BROWSER            = "firefox";
        TERMINAL           = "alacritty";
        FILES              = "nautilus";
      };
    };
  };
}
