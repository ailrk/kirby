{ config, lib, pkgs, ... }:
let
  cfg = config.elemental.home.program.editor.neovim;

in
{
  options.elemental.home.program.editor.neovim = {
    enable = lib.mkEnableOption "Enable the neovim editor";
  };

  config = lib.mkIf cfg.enable {

    programs.neovim = {
      enable = true;
      extraConfig = ''
        source $HOME/.config/nvim/init.vim
      '';
    };

    xdg.configFile."nvim/lua".source = ./lua;
    xdg.configFile."nvim/coc-settings.json".source = ./coc-settings.json;

    xdg.configFile."nvim/init.vim".source = ./init.vim;

    xdg.configFile."nvim/common.vim".source = ./configs/common.vim;
    xdg.configFile."nvim/debug.vim".source = ./configs/debug.vim;
    xdg.configFile."nvim/languages.vim".source = ./configs/languages.vim;
    xdg.configFile."nvim/lsp.vim".source = ./configs/lsp.vim;
    xdg.configFile."nvim/adhoc.vim".source = ./configs/adhoc.vim;
    xdg.configFile."nvim/theme.vim".source = ./configs/theme.vim;
    xdg.configFile."nvim/utils.vim".source = ./configs/utils.vim;
  };
}
