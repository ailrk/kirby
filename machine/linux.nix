# General configurations for linux machines

{
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
}
