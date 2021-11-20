if [ -e /home/jimmy/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jimmy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export CARGO_HOME=$HOME/.cargo
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
export LOCALE_ARCHIVE=$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
