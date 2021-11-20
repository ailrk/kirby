{ config, lib, pkgs, ... }:
let
  cfg = config.elemental.home.program.shell.zsh;
  pre = ./zshrc.pre;
  local = ./zshrc.local;
in
{
  options.elemental.home.program.shell.zsh = {
    enable = lib.mkEnableOption "Enable zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      # oh to get type.lines you can just read a file.
      initExtraFirst = builtins.readFile ./zshrc.pre;
      initExtra = builtins.readFile ./zshrc.local;

      initExtraBeforeCompInit = ''
        source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
        # Make user colour green in prompt instead of default blue
        zstyle ':prompt:grml:left:items:user' pre '%F{green}%B'
        source ${local}
        '';
    };
  };
}
