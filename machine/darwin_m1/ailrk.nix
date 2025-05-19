# ailrk
{ config, lib, pkgs, ... }:
with lib;
{
  imports = [
    ../../program/darwin.nix
    ../../service/default.nix
  ];

  options.kirby.home.darwin_m1.ailrk = {
    enable  = mkEnableOption "Set user as a ailrk";
    colorMode = mkOption {
      type = types.enum ["dark" "light"];
      default = "dark";
      description = "color mode of the system";
    };
  };

  config = mkIf config.kirby.home.darwin_m1.ailrk.enable {
    home.stateVersion = "24.05";
    home.username = "ailrk";
    home.homeDirectory = "/Users/ailrk";
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
        scripts.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
      };
    };

    # Install packages
    home.packages = [
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
          pkgs.tldr
          pkgs.w3m
          pkgs.any-nix-shell
          pkgs.fira-code
          pkgs.cabal2nix
          pkgs.haskellPackages.ghcup
          pkgs.ghcid
        ];

    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome-stable";
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
