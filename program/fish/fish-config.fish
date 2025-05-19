set -x TERM xterm
set PATH $PATH $HOME/Opt/bin/
set PATH $PATH $HOME/Opt/Discord/
set PATH $PATH $HOME/Opt/cross/bin/
set PATH $PATH $HOME/.local/bin/
set PATH $PATH $HOME/.cargo/bin/
set PATH $PATH $HOME/.cabal/bin/
set PATH $PATH $HOME/.ghcup/bin/
set PATH $PATH $HOME/.config/scripts/

# temporary
set PATH $PATH $HOME/Opt/Dyalog/opt/mdyalog/18.0/64/unicode

# alias
alias vim="nvim"
alias g="git"
alias ssrsa="bass eval '$(ssh-agent -s)' && ssh-add -k ~/.ssh/id_rsa"
alias ssid25519="bass eval '$(ssh-agent -s)' && ssh-add -k ~/.ssh/id_ed25519"
alias fh="cat ~/.local/share/fish/fish_history"
alias qq="exit"
alias smli="rlwrap -A -p -r smlnj"
alias ocamli="rlwrap -A -p -r ocaml"
alias cpwd="pwd | xclip -sel clip"
alias t="tmux"
direnv hook fish | source
