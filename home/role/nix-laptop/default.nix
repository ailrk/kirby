{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.home.role.nix-laptop;
in
{
  imports = [
    # DE
    ./de/compton/default.nix
    ./de/dunst/default.nix
    ./de/polybar/default.nix
    ./de/bspwm/default.nix
    ./de/sxhkd/default.nix
  ];

  options.kirby.home.role.nix-laptop = {
    enable = mkEnableOption "Enable linux nix laptop role";
  };

  config = mkIf (config.kirby.role == "nix-laptop") {

    # Setup lorri and mpd

    # kirby.home.service.dev.lorri.enable = true;
    # kirby.home.service.mpd.enable = true;
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.pulseaudio = true;

    kirby.home.program.alacritty.enable = true;
    kirby.home.program.scripts.enable = true;
    kirby.home.program.rofi = {
      enable = true;
      resolution = "720p";
    };


    home.packages = with pkgs; [
      brightnessctl
      xdotool
      xtitle
      lsof
      xdo
      pinentry
      libnotify
      w3m
      xclip

    ];

    fonts.fontconfig.enable = true;
    xdg.configFile."nix/nix.conf".source = ./nix.conf;

    xsession = {
      enable = true;
      scriptPath = ".hm-xsession";
      initExtra = ''
        xset -b
      '';

      # NOTE:
      # in /etc/nixos/configuration.nix add
      #   services.xserver.desktopManager.sessoin = [
      #     name = "home-manager";
      #     start = ''
      #       ${pkgs.runtimeShell} $HOME/.hm-xsession &
      #       waitPID=$!
      #     '';
      #   ];
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
