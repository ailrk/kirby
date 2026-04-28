# ailrk
{ config, lib, pkgs, ... }:
with lib;
let
  cfg   = config.kirby.home.linux_m1.ailrk;
  NIXGL = "nixGLIntel";
in
{
  imports = [
    ../program/default.nix
    ../service/default.nix
    ./linux.nix
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
        fcitx5.enable = true;
      };
      service = {
        ollama.enable = true;
      };
      linux.enable = true;
    };

    # Install packages
    home.packages = [
          inputs.nixgl.packages.${pkgs.system}.nixVulkanIntel
          inputs.nixgl.packages.${pkgs.system}.nixGLIntel

          # libraries
          pkgs.libGL
          pkgs.libgcc
          pkgs.gtk4
          pkgs.chromium
          pkgs.aseprite
          pkgs.tiled
        ] ++ pkgs.callPackage ../packages.nix {};


    # Environment
    home.sessionVariables = {
      WSTART             = "${NIXGL} labwc";
      NIX_REMOTE         = "daemon";
      NIXGL              = "${NIXGL}";
      FILES              = "nautilus";
      EDITOR             = "nvim";
      BROWSER            = "chromium";
      TERMINAL           = "alacritty";
      BATTERY            = "macsmc-battery";
      BATTERY_ADAPTOR    = "macsmc-ac";
    };

    # User specific overlays.
    nixpkgs.overlays = [
    ];
  };
}
