{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.program.fcitx5;
in
{
  options.kirby.program.fcitx5 = {
    enable = mkEnableOption "Enable fcitx5";
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-rime
        fcitx5-mozc
        fcitx5-gtk
        qt6Packages.fcitx5-chinese-addons
      ];
    };

    # Global Config
    xdg.configFile."fcitx5/config".text = ''
      [Hotkey/TriggerKeys]
      0=Control+Alt+space

      [Hotkey/AltTriggerKeys]
      0=Shift_L
    '';

    # Profile Config - Note the name 'pinyin' vs 'fcitx-pinyin'
    xdg.configFile."fcitx5/profile".text = ''
      [Groups/0]
      Name=Default
      Default Layout=us
      DefaultIM=keyboard-us

      [Groups/0/Items/0]
      Name=keyboard-us

      [Groups/0/Items/1]
      Name=pinyin

      [GroupList]
      0=Default
    '';

    # Chinese specific - ENSURE NO LEADING DOT IN THE ATTRIBUTE NAME
    xdg.configFile."fcitx5/conf/pinyin.conf".text = ''
      PageSize=10
      CloudPinyinEnabled=True
      PreeditInApplication=True
    '';

    # Required environment variables for apps to recognize fcitx5
    home.sessionVariables = {
      GTK_IM_MODULE = lib.mkForce "";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
  };
}
