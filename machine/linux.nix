# General configurations for linux machines

{ config, lib, pkgs, ... }:
with lib;
{
  options.kirby.linux = {
    enable  = mkEnableOption "Enable generic linux settings";
  };

  config = mkIf config.kirby.linux.enable {
    xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <match target="pattern">
      <test name="family" qual="any">
      <string>PxPlus IBM VGA 9x16</string>
      </test>
      <!-- Only append ZPix for Chinese charset -->
      <edit name="family" mode="append" binding="weak">
      <string>ZPix</string>
      </edit>
      </match>

      <!-- Restrict ZPix usage to CJK -->
      <match target="pattern">
      <test name="lang" compare="contains">
      <string>zh</string>
      </test>
      <edit name="family" mode="prepend" binding="strong">
      <string>ZPix</string>
      </edit>
      </match>
    </fontconfig>
    '';

    nixpkgs.config = {
      allowUnfree = true;
      pulseaudio = true;
    };

    nix = {
    package = pkgs.nix;

    settings = {
      experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
      warn-dirty = false;
    };
  };

    fonts.fontconfig.enable = true;

    home.sessionVariables = {
      NIX_PATH        = "$HOME/.nix-defexpr/channels";
      BATTERY         = "macsmc-battery";
      BATTERY_ADAPTOR = "macsmc-ac";
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
