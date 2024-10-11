# ailrk-asahi
{ config, lib, pkgs, ... }:
with lib;
{
  options.kirby.user.linux_m1.ailrk_asahi = {
    enable  = mkEnableOption "Set user as a ailrk-asahi";
    core    = mkEnableOption "Core utilities";
    cli     = mkEnableOption "Extra cli utilties";
    haskell = mkEnableOption "Haskell related";
    gui     = mkEnableOption "GUI related";
    app     = mkEnableOption "GUI applications";
    langs   = mkEnableOption "Misc language tools";
    nix     = mkEnableOption "Nix related";
    fonts   = mkEnableOption "Fonts";
    extra   = lib.mkOption {
      type = types.listOf types.package;
      description = "extra packages";
      default = [];
    };
  };

  config = mkIf config.kirby.user.linux_m1.ailrk_asahi.enable {
    home.stateVersion = "24.05";
    home.username = "ailrk-asahi";
    home.homeDirectory = "/home/ailrk-asahi";
    manual.manpages.enable = false;

    kirby = {
      program = {
        git = {
          enable = true;
          userEmail = "jimmy123good@gmail.com";
          userName = "Ailrk";
          signByDefault = true;
          signKey = "~/.ssh/id_ed25519.pub";
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
        sxhkd.enable = true;
        dunst.enable = true;
        alacritty.enable = true;
        polybar.enable = true;
        scripts.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
        nemo.enable = true;
        taskwarrior.enable = true;
        xconfig.enable = true;
        rofi = {
          enable = true;
          resolution = "720p";
        };
      };
    };

    # Install packages
    home.packages = let
        ailrk_asahi = config.kirby.user.linux_m1.ailrk_asahi;
        set = en: ps: if en then ps else [];

        core = set ailrk_asahi.core [
          pkgs.tmux
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
          pkgs.zlib.dev
          pkgs.zlib.out
          pkgs.texinfo
          pkgs.texliveSmall
          pkgs.libgcc
        ];

        cli = set ailrk_asahi.cli [
          pkgs.tldr
          pkgs.w3m
          pkgs.gnupatch
          (with import <nixgl> { enable32bits = false; }; nixGLMesa)
        ];

        langs = set ailrk_asahi.langs [
          pkgs.racket
          pkgs.valgrind
          pkgs.ocaml
          pkgs.opam
          pkgs.ocamlPackages.ocaml-lsp
          pkgs.cmake
          pkgs.rustup
          pkgs.nodejs
          pkgs.gnumake
          pkgs.gcc
          pkgs.clang-tools
          pkgs.gdb
          pkgs.lld
          pkgs.bear
          pkgs.nasm
        ];

        nix = set ailrk_asahi.nix [
          pkgs.any-nix-shell
        ];

        fonts = set ailrk_asahi.fonts [
          pkgs.fira-code
          pkgs.paratype-pt-mono
          pkgs.noto-fonts-cjk-sans
          pkgs.noto-fonts-cjk-serif
        ];

        haskell = set ailrk_asahi.haskell [
          pkgs.ghc
          pkgs.haskell-language-server
          pkgs.ghciwatch
          pkgs.cabal-install
        ];

        gui = set ailrk_asahi.gui [
          pkgs.xorg.xset
          pkgs.xorg.xinput
          pkgs.brightnessctl
          pkgs.xdotool
          pkgs.xtitle
          pkgs.xdo
          pkgs.pinentry
          pkgs.xclip
        ];

        app = set ailrk_asahi.app [
          pkgs.ibus
          pkgs.chromium
          pkgs.wireshark-qt
          pkgs.xournalpp
          pkgs.blueman
          pkgs.mupdf
          pkgs.zathura
          pkgs.font-manager
        ];

      in
      core
      ++ cli
      ++ nix
      ++ langs
      ++ fonts
      ++ haskell
      ++ gui
      ++ app
      ++ ailrk_asahi.extra;

    home.file = {
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

    xdg.configFile = {
      "nix/nix.conf".source = ./nix.conf;
    };

    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "chromium";
      TERMINAL = "nixGLMesa alacritty";
      TERM = "nixGLMesa alacritty";
    };

    nixpkgs.config = {
      allowUnfree = true;
      pulseaudio = true;
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
