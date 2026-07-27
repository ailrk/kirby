fish_config theme choose default

# Use vim binding. We need to restore Ctl-R for command history
fish_vi_key_bindings
bind -M insert \cr history-pager
bind -M default \cr history-pager

set PATH $PATH $HOME/Opt/bin/
set PATH $PATH $HOME/Opt/Discord/
set PATH $PATH $HOME/Opt/cross/bin/
set PATH $PATH $HOME/.local/bin/
set PATH $PATH $HOME/.cargo/bin/
set PATH $PATH $HOME/.cabal/bin/
set PATH $PATH $HOME/.ghcup/bin/
set PATH $PATH $HOME/.config/scripts/

# alias
alias vim="nvim"
alias g="git"
alias ls="eza --header --git"
alias ssrsa="bass eval '$(ssh-agent -s)' && ssh-add -k ~/.ssh/id_rsa"
alias ssid25519="bass eval '$(ssh-agent -s)' && ssh-add -k ~/.ssh/id_ed25519"
alias fh="cat ~/.local/share/fish/fish_history"
alias qq="exit"
alias t="tmux"
direnv hook fish | source
