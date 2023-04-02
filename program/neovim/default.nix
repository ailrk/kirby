{ config, lib, pkgs, ... }:
let
  cfg = config.kirby.program.neovim;

in
{
  options.kirby.program.neovim = {
    enable = lib.mkEnableOption "Enable the neovim editor";
  };

  config = lib.mkIf cfg.enable {

    programs.neovim = {
      enable = true;
      extraConfig = ''
        source $HOME/.config/nvim/init.vim
      '';
    };

    xdg.configFile."nvim/init.vim".source = ./init.vim;
    xdg.configFile."nvim/lua".source = ./lua;
  };
}
