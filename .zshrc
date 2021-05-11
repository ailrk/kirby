# Created by newuser for 5.6.2
function nix_shell_prompt () {
    REPLY=${IN_NIX_SHELL+(nix) }
}
function py_virtual_env_prompt () {
    REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
}
grml_theme_add_token nix-shell -f nix_shell_prompt '%F{megenta}' '%f'
grml_theme_add_token py-virtual-env -f py_virtual_env_prompt '%F{magenta}' '%f'
autoload -U colors && colors
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"
zstyle ':prompt:grml:left:setup' items rc change-root path nix-shell py-virtual-env vcs newline percent
