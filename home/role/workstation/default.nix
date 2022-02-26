{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.home.role.workstation;
  # location = import ./location.nix;
in
{
  imports = [
    # DE
    ./de/dunst/default.nix
    ./de/compton/default.nix
    ./de/polybar/default.nix
    ./de/bspwm/default.nix
    ./de/sxhkd/default.nix
  ];

  options.kirby.home.role.workstation = {
    enable = mkEnableOption "Enable linux workstation role";
  };

  config = mkIf (config.kirby.role == "workstation") {
    kirby.home.program.alacritty = {
      enable = true;
      settingOverrides = {
        font.size = 13;
        font.user_thin_strokes = false;
        window = {
          decorations = "full";
        };
      };
    };

    # Setup lorri and mpd
    # kirby.home.service.dev.lorri.enable = true;
    # kirby.home.service.mpd.enable = true;

    kirby.home.program.scripts.enable = true;
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.pulseaudio = true;

    home.packages = with pkgs; [
      ncmpcpp
      zathura
      wireshark-qt
      mpd

      brightnessctl
      xdotool
      xtitle
      lsof
      xdo
      gcc
      pinentry
    ];

    xsession = {
      enable = true;
      scriptPath = ".hm-xsession";
      initExtra = ''
        xset -b
      '';

      windowManager.command = ''
        bspwm
        ${pkgs.xterm}/bin/xterm -ls
      '';
    };

    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome-stable";
      TERMINAL = "alacritty";
    };

    services.gpg-agent = {
     enable = true;
    };
  };
}
