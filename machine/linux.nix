# General configurations for linux machines

{ config, lib, pkgs, ... }:
with lib;
{

  options.kirby.linux = {
    enable  = mkEnableOption "Enable generic linux settings";
  };

  config = mkIf config.kirby.linux.enable {
    sops = {
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      defaultSopsFile = ../secrets/secret.yaml;
      secrets = {
         OPENROUTER_API_KEY = {};
         GEMINI_API_KEY = {};
         MISTRAL_API_KEY = {};
      };
      templates = {
        "litellm-env".content = ''
          OPENROUTER_API_KEY=${config.sops.placeholder.OPENROUTER_API_KEY}
          GEMINI_API_KEY=${config.sops.placeholder.GEMINI_API_KEY}
          MISTRAL_API_KEY=${config.sops.placeholder.MISTRAL_API_KEY}
        '';
      };
    };

    xdg.configFile."fontconfig/conf.d/99-custom.conf".text = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <!-- Append ZPix as a fallback for PxPlus IBM VGA 9x16 -->
          <match target="pattern">
            <test name="family" qual="any">
              <string>PxPlus IBM VGA 9x16</string>
            </test>
            <edit name="family" mode="append" binding="weak">
              <string>ZPix</string>
            </edit>
          </match>
        </fontconfig>
        '';

    xdg.dataFile = {
      "icons/hicolor/32x32/apps/console.png" = {
        source = ../static/icon/console-32.png;
      };

      "icons/hicolor/64x64/apps/console.png" = {
        source = ../static/icon/console-64.png;
      };
    };

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

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "PxPlus IBM VGA 9x16"
        "ZPix"
        "Noto Sans Mono CJK SC" # A good tertiary fallback
      ];
      sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
      serif = [ "Noto Serif" "Noto Serif CJK SC" ];
    };
  };

  gtk = {
    enable = true;
    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
      size = 11;
    };
  };

  home.activation.updateIconCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${pkgs.gtk3}/bin/gtk-update-icon-cache $VERBOSE_ARG ~/.local/share/icons/hicolor
  '';

  home.sessionVariables = {
    NIX_PATH       = "$HOME/.nix-defexpr/channels";
    LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  };

    # User specific overlays.
    nixpkgs.overlays = [
    ];
  };
}
