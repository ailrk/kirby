fish_config theme choose default

# Use vim binding. We need to restore Ctl-R for command history
fish_vi_key_bindings
bind -M insert \cr history-pager
bind -M default \cr history-pager


# Binding for command bible.
function cbb
    set -l chosen_cmd (~/.config/cbb/cbb)

    # If a command was selected, inject it into the command line buffer
    if test -n "$chosen_cmd"
        commandline -r "$chosen_cmd"
        commandline -f repaint
    end
end


# Set path
set PATH $PATH $HOME/Opt/bin/
set PATH $PATH $HOME/Opt/Discord/
set PATH $PATH $HOME/Opt/cross/bin/
set PATH $PATH $HOME/.local/bin/
set PATH $PATH $HOME/.cargo/bin/
set PATH $PATH $HOME/.cabal/bin/
set PATH $PATH $HOME/.ghcup/bin/
set PATH $PATH $HOME/.config/scripts/

set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"

# alias
alias vim="nvim"
alias g="git"
alias ls="eza --header --git"
alias ssrsa="bass eval '$(ssh-agent -s)' && ssh-add -k ~/.ssh/id_rsa"
alias ssid25519="bass eval '$(ssh-agent -s)' && ssh-add -k ~/.ssh/id_ed25519"
alias qq="exit"
alias t="tmux"
alias hfz="find $HOME | fzf --header='Find from $HOME'"
alias ffz="find . | fzf --header='Find from .'"
direnv hook fish | source
