{ config, lib, pkgs, ... }:
with lib;
{
  config = mkIf (config.kirby.user == "ailrk") {
    kirby.home = {
      program = {
        # admin.topgrade.enable = true;
        # networking.ssh.enable = true;
        nmap.enable = true;
        emacs.enable = true;
        neovim.enable = true;
        zsh.enable = true;
        fish.enable = true;
        ranger.enable = true;
        tmux.enable = true;
        taskwarrior.enable = true;
      };
    };

    # Install packages
    home.packages = with pkgs;
    let
      common = [
        tmux


        # utils
        zlib.dev
        zlib.out
        gmp
        cabal2nix

        # cli tools
        htop
        inetutils
        ripgrep
        killall
        expect
        fd
        bat
        fzf
        git-crypt
        gnupg

        # font
        fira-code

        # nix
        any-nix-shell
      ];

      linux = lib.optionals stdenv.isLinux [
        # font
        iosevka
        meslo-lg

        # language
        smlnj
        racket
        purescript
        valgrind
        dotnet-sdk
        fsharp

        # Data, Files and Networking
        sshfs
        iotop
        fio
        acpi
        scrot

        # user
        google-chrome
        wireshark-qt
        muse
        blender
        xournalpp
        aseprite
        xfce.thunar
        blueman

        # languages
        gnumake
        ocaml
        cmake
        lua
        rebar3
        rustup
        nodejs

        # Jokes
        cowsay
        fortune
        figlet
        lolcat
        nms


        # others
        mupdf
        ncmpcpp
        zathura
      ];

      unfree = lib.optionals stdenv.isLinux [
        tdesktop
        discord
      ];

    in
    common ++ linux ++ unfree;
  };
}
