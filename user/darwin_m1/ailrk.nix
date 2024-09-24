# ailrk
{ config, lib, pkgs, ... }:
with lib;
{
  options.kirby.user.darwin_m1.ailrk = {
    enable  = mkEnableOption "Set user as a ailrk";
    core    = mkEnableOption "Core utilities";
    cli     = mkEnableOption "Extra cli utilties";
    haskell = mkEnableOption "Haskell related";
    nix     = mkEnableOption "Nix related";
    fonts   = mkEnableOption "Fonts";
    extra   = lib.mkOption {
      type = types.listOf types.package;
      description = "extra packages";
      default = [];
    };
  };

  config = mkIf config.kirby.user.darwin_m1.ailrk.enable {
    home.stateVersion = "24.05";
    home.username = "ailrk";
    home.homeDirectory = "/Users/ailrk";
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
        scripts.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
      };
    };

    # Install packages
    home.packages = let
        ailrk = config.kirby.user.darwin_m1.ailrk;
        set   = en: ps: if en then ps else [];

        core = set ailrk.core [
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
        ];

        cli = set ailrk.cli [
          pkgs.tldr
          pkgs.w3m
        ];

        nix = set ailrk.nix [
          pkgs.any-nix-shell
        ];

        fonts = set ailrk.fonts [
          pkgs.fira-code
        ];

        haskell = set ailrk.haskell [
          pkgs.cabal2nix
          pkgs.haskellPackages.ghcup
          pkgs.ghcid
        ];
      in
      core
      ++ cli
      ++ nix
      ++ fonts
      ++ haskell
      ++ ailrk.extra;

    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome-stable";
      TERMINAL = "kitty";
    };

    nixpkgs.config = {
      allowUnfree = true;
      pulseaudio = true;
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
