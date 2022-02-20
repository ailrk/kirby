{
  imports = [
    # ./admin/topgrade/default.nix
    # ./networking/nmap/default.nix
    # ./networking/ssh/default.nix
    ./dev/git/default.nix
    ./scripts/index.nix

    ./shell/zsh/default.nix
    ./shell/fish/default.nix
    ./file-manager/ranger/default.nix
    ./editor/neovim/default.nix
    ./editor/emacs/default.nix
    ./terminal/tmux/default.nix
    ./terminal/alacritty/default.nix
  ];
}
