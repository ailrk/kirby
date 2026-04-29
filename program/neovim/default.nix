{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.kirby.program.neovim;
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
      package = pkgs.neovim-unwrapped;
      withPython3 = true;
      extraPython3Packages = ps: with ps; [
        pygls
        pynvim
      ];
    };

    xdg.configFile."nvim/main.vim".source = ./main.vim;
    xdg.configFile."nvim/lua".source = ./lua;

    nixpkgs.overlays =
      if cfg.nightly
      then [ inputs.neovim-nightly.overlays.default ]
      else [];
  };
}
