# fatmonad
{ config, lib, pkgs, ... }:
with lib;
{
  options.kirby.user.linux_x86.fatmonad = {
    enable  = mkEnableOption "Set user as a fatmonad";
    core    = mkEnableOption "Core utilities";
    cli     = mkEnableOption "Extra cli utilties";
    libs    = mkEnableOption "Libraries";
    gui     = mkEnableOption "GUI related";
    nix     = mkEnableOption "Nix related";
    fonts   = mkEnableOption "Fonts";
    app     = mkEnableOption "GUI applications";
    langs   = mkEnableOption "Misc language tools";
    lsp     = mkEnableOption "Lsps";
    extra   = lib.mkOption {
      type = types.listOf types.package;
      description = "extra packages";
      default = [];
    };
  };

  config = mkIf config.kirby.user.linux_x86.fatmonad.enable {
    home.stateVersion = "24.05";
    home.username = "fatmonad";
    home.homeDirectory = "/home/fatmonad";
    manual.manpages.enable = false;

    kirby = {
      program = {
        git = {
          enable = true;
          userEmail = "jimmy123good@gmail.com";
          userName = "Ailrk";
          signByDefault = true;
          signKey = "~/.ssh/id_rsa.pub";
          extraConfig = {
            gpg.format = "ssh";
          };
        };
        neovim = {
          enable = true;
          nightly = false;
        };
        ranger.enable = true;
        tmux.enable = true;
        bspwm.enable = true;
        compton.enable = true;
        polybar.enable = true;
        sxhkd.enable = true;
        dunst.enable = true;
        alacritty.enable = true;
        scripts.enable = true;
        xconfig.enable = true;
        rofi.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
        nemo.enable = true;
        taskwarrior.enable = true;
      };

      service = {
        dropbox.enable = true;
      };
    };

    services.gpg-agent = {
     enable = true;
    };

    nixpkgs.config = {
      allowUnfree = true;
      pulseaudio = true;
    };

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; with pkgs.fcitx5; [ fcitx5-rime fcitx5-mozc fcitx5-gtk fcitx5-chinese-addons ];
    };

  fonts.fontconfig.enable = true;

    # Install packages
    home = {
      packages = let
        fatmonad = config.kirby.user.linux_x86.fatmonad;
        set   = en: ps: if en then ps else [];
        core = set fatmonad.core [
          pkgs.binutils
          pkgs.rsync
          pkgs.htop
          pkgs.inetutils
          pkgs.ripgrep
          pkgs.killall
          pkgs.expect
          pkgs.fd
          pkgs.bat
          pkgs.fzf
          pkgs.git-crypt
          pkgs.gnupg
          pkgs.lsof
        ];

        cli = set fatmonad.cli [
          pkgs.tldr
          pkgs.w3m
          pkgs.sshfs
          pkgs.fio
          pkgs.acpi
          pkgs.scrot
          pkgs.ncmpcpp
          pkgs.lldb
          pkgs.qemu
        ];

        libs = set fatmonad.libs [
          pkgs.zlib.dev
          pkgs.zlib.out
          pkgs.libGL
          pkgs.libnotify
        ];

        nix = set fatmonad.nix [
          pkgs.any-nix-shell
        ];

        fonts = set fatmonad.fonts [
          pkgs.fira-code
          pkgs.paratype-pt-mono
          pkgs.iosevka
          pkgs.meslo-lg
        ];

        gui = set fatmonad.gui [
          pkgs.brightnessctl
          pkgs.xdotool
          pkgs.xtitle
          pkgs.xdo
          pkgs.pinentry
          pkgs.xclip
        ];

        app = set fatmonad.app [
          pkgs.ibus
          pkgs.google-chrome
          pkgs.wireshark-qt
          pkgs.muse
          pkgs.blender
          pkgs.xournalpp
          pkgs.aseprite
          pkgs.xfce.thunar
          pkgs.blueman
          pkgs.mupdf
          pkgs.tdesktop
          pkgs.discord
          pkgs.zathura
        ];

        langs = set fatmonad.langs [
          pkgs.smlnj
          pkgs.racket
          pkgs.purescript
          pkgs.valgrind
          pkgs.dotnet-sdk
          pkgs.fsharp
          pkgs.gnumake
          pkgs.ocaml
          pkgs.cmake
          pkgs.rebar3
          pkgs.rustup
          pkgs.nodejs
        ];

        lsp = set fatmonad.lsp [
          pkgs.nil
          pkgs.nodePackages.bash-language-server
          pkgs.nodePackages.typescript-language-server
        ];

      in
      core
      ++ cli
      ++ libs
      ++ nix
      ++ fonts
      ++ gui
      ++ app
      ++ langs
      ++ lsp
      ++ fatmonad.extra;


      file = {
        ".xinitrc" = {
          executable = true;
          text = builtins.readFile ./.xinitrc;
        };

        ".xsession" = {
          executable = true;
          text = builtins.readFile ./.xsession;
        };

        ".xprofile" = {
          executable = true;
          text = builtins.readFile ./.xprofile;
        };

        ".profile" = {
          executable = true;
          text = builtins.readFile ./.profile;
        };

        ".Xresources" = {
          executable = true;
          text = builtins.readFile ./.Xresources;
        };
      };

      # Environment
      sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "google-chrome-stable";
        TERMINAL = "nixGL alacritty";
        TERM = "nixGL alacritty";
        FILES = "nautilus";
      };
    };

    xdg.configFile = {
      "bspwm/bspwmrc" = {
          source = ./bspwmrc;
          executable = true;
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
