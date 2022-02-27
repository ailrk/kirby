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

    # Setup lorri and mpd
    # kirby.home.service.dev.lorri.enable = true;
    # kirby.home.service.mpd.enable = true;

    kirby.home.program.alacritty.enable = true;
    kirby.home.program.scripts.enable = true;
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.pulseaudio = true;

    home.packages = with pkgs; [
      brightnessctl
      xdotool
      xtitle
      lsof
      xdo
      pinentry
      w3m
    ];

    fonts.fontconfig.enable = true;

    # programs.bash = {
    #   enable = true;
    #   profileExtra = ''
    #     export XDG_DATA_DIRS=$HOME/.nix-profile/share''${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS
    #     export LIBGL_ALWAYS_INDIRECT=1
    #     export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
    #     if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    #         . $HOME/.nix-profile/etc/profile.d/nix.sh;
    #     fi
    #   '';
    #   initExtra = ''
    #      if [ -z $IN_NIX_SHELL ]; then
    #          exec fish
    #     fi
    #   '';
    # };


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
