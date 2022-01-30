{ config, lib, pkgs, ... }:
with lib;
{
  config = mkIf (config.elemental.user == "ailrk") {
    elemental.home = {
      program = {
        # admin.topgrade.enable = true;
        # networking.ssh.enable = true;
        # networking.nmap.enable = true;

        shell.zsh.enable = true;
        shell.fish.enable = true;

        # TODO nix version is somehow broken.
        #      press q ranger will exit the entire shell!
        #      not sure what happend, I have to fall back to
        #      archlinux version
        # filemanager.ranger.enable = true;
        scripts.enable = true;
        terminal.tmux.enable = true;

        editor.emacs.enable = true;
        editor.neovim.enable = true;

        # dev.git = {
        #   enable = true;

        #   userEmail = "hugo@hugoreeves.com";
        #   userName = "Hugo Reeves";
        #   gpgKey = "0xE5D84E498A9A056E";
        #   signByDefault = true;
        # };
      };
    };

    # Install packages
    home.packages = with pkgs; [
      tmux

      # terms
      direnv

      # utils
      zlib.dev
      zlib.out
      gmp
      cabal2nix
      haskellPackages.ghcup

      # cli tools


      # Jokes
      cowsay
      fortune
      figlet
      lolcat
      nms
    ] ++ lib.optionals stdenv.isLinux [
      # Data, Files and Networking
      sshfs
      iotop
      fio
    ];
  };
}
