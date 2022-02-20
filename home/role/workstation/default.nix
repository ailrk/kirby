{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.elemental.home.role.workstation;
  # location = import ./location.nix;
in
{
  imports = [
    # DE
    # ./de/polybar/default.nix
    ./de/dunst/default.nix
    ./de/compton/default.nix

    ./de/bspwm/default.nix
    ./de/sxhkd/default.nix
  ];

  options.elemental.home.role.workstation = {
    enable = mkEnableOption "Enable linux workstation role";
  };

  config = mkIf (config.elemental.role == "workstation") {
    # elemental.home.program.terminal.alacritty = {
    #   enable = true;
    #   settingOverrides = {
    #     font.size = 11;
    #     font.user_thin_strokes = false;
    #     window = {
    #       decorations = "full";
    #     };
    #   };
    # };

    elemental.home.program.scripts.scriptFiles = {
      "lock-screen" = ./script/lock-screen;
      "lock-screen-i3" = ./script/lock-screen-i3;
      "set-wall" = ./script/set-wall;
      "bspwpm-workspace-preview" = ./script/bspwm-workspace-preview;
    };

    # Setup lorri and mpd
    # TODO
    # elemental.home.service.dev.lorri.enable = true;
    # elemental.home.service.media.mpd.enable = true;

    nixpkgs.config.allowUnfree = true;
    # nixpkgs.config.pulseaudio = true;

    home.packages = with pkgs; [
      bspwm
      sxhkd

      dunst
      compton

      ncmpcpp
      zathura

      # Graphical
      #anki
      # joplin-desktop
      # thunderbird
      # librecad
      wireshark-qt
      # zoom-us

      # Devlopment Graphical
      # android-studio
      # vscode
    ];


    # services = {
    #   redshift = {
    #     enable = true;
    #     latitude = location.latitude;
    #     longitude = location.longitude;
    #     temperature = {
    #       day = 5700;
    #       night = 3000;
    #     };
    #   };

    # };

    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "urxvt";
    };

    # programs.gpg = {
    #   enable = true;
    #   settings = {
    #     default-key = "F3F42E1F26FE5C63A19D3061FA5C94EDD085C989";
    #   };
    # };

    # services.gpg-agent = {
    #   enable = true;
    #   extraConfig = ''
    #     pinentry-program /run/current-system/sw/bin/pinentry-gtk-2
    #   '';
    # };
  };
}
