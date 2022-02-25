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
    ./de/rofi/default.nix
  ];

  options.kirby.home.role.workstation = {
    enable = mkEnableOption "Enable linux workstation role";
  };

  config = mkIf (config.kirby.role == "workstation") {
    kirby.home.program.terminal.alacritty = {
      enable = true;
      settingOverrides = {
        font.size = 11;
        font.user_thin_strokes = false;
        window = {
          decorations = "full";
        };
      };
    };

    # kirby.home.program.scripts.scriptFiles = {
    #   "lock-screen" = ./script/lock-screen;
    #   "lock-screen-i3" = ./script/lock-screen-i3;
    #   "set-wall" = ./script/set-wall;
    #   "bspwpm-workspace-preview" = ./script/bspwm-workspace-preview;
    # };

    # Setup lorri and mpd
    # kirby.home.service.dev.lorri.enable = true;
    # kirby.home.service.media.mpd.enable = true;

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.pulseaudio = true;

    home.packages = with pkgs; [
      ncmpcpp
      zathura
      wireshark-qt
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

    programs.gpg = {
      enable = true;
      settings = {
        default-key = "F3F42E1F26FE5C63A19D3061FA5C94EDD085C989";
      };
    };

    services.gpg-agent = {
      enable = true;
      extraConfig = ''
        pinentry-program /run/current-system/sw/bin/pinentry-gtk-2
      '';
    };
  };
}
