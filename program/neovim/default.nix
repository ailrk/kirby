{ config, lib, pkgs, ... }:
let
  cfg = config.kirby.program.neovim;
  nightly = import (builtins.fetchTarball { url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz; });
in
{
  options.kirby.program.neovim = {
    enable = lib.mkEnableOption "Enable the neovim editor";
    nightly = lib.mkEnableOption "Enable nvim nightly overlay";

  };

  config = lib.mkIf cfg.enable {

    programs.neovim = {
      enable = true;
      extraConfig = ''
        source $HOME/.config/nvim/main.vim
      '';
    };

    xdg.configFile."nvim/main.vim".source = ./main.vim;
    xdg.configFile."nvim/lua".source = ./lua;

    nixpkgs.overlays = if cfg.nightly then [ nightly ] else [];

  };
}
