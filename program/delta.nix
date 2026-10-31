{ lib, config, ... }:
with
lib;
let
  cfg = config.kirby.program.delta;
in
{
  options.kirby.program.delta = {
    enable = mkEnableOption "Enable delta";
  };

  config = mkIf cfg.enable {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = true;
        dark = true;

        # Muted line backgrounds that sit better on a warm dark gray
        minus-style = "syntax #3a2a2e";
        plus-style = "syntax #2a3a2e";

        # Subtler word-level highlights (instead of the bright blocks)
        minus-emph-style = "syntax #5c3036";
        plus-emph-style = "syntax #31523a";

        # Readable line numbers
        line-numbers-left-style = "#6b6b6b";
        line-numbers-right-style = "#6b6b6b";
        line-numbers-minus-style = "#c06070";
        line-numbers-plus-style = "#70b080";
        line-numbers-zero-style = "#6b6b6b";

        # Cleaner hunk headers: no boxes
        hunk-header-style = "file line-number syntax";
        hunk-header-decoration-style = "#5f6b7a ul";
        file-decoration-style = "#5f6b7a ul";

        # Blame
        blame-code-style = "syntax";
        blame-format = "{author:<18} ({commit:>7}) {timestamp:^16}";
        blame-palette = "#2a2a2e #323236 #3a3a3e"; # alternating background per commit
        blame-separator-format = "│{n:^4}│";
        blame-timestamp-output-format = "%Y-%m-%d %H:%M";
      };
    };
  };
}
