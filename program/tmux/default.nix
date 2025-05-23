{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.kirby.program.tmux;
in
{
  options.kirby.program.tmux = {
    enable = mkEnableOption "Enable tmux terminal multiplexer";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.tmux ];
    xdg.configFile."tmux/tmux.conf".text = ''
      # escape delay
      set -s escape-time 0
      set-option -g default-shell '${pkgs.fish}/bin/fish'

      set-option -g status-left '#[fg=green,bold] #(whoami)@#H#[default] [#S] '
      set-option -g status-left-length 50

      set -g status-right-style 'fg=black bg=yellow'
      set -g status-right ' %Y-%m-%d %H:%M '
      set -g status-right-length 50

      set-option -g window-status-format ' #I #W '
      set-option -g window-status-current-format ' #I #W *'

      ##prefix
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix

      ## general
      # set -g default-terminal "rxvt-unicode-256color"
      unbind l
      unbind n
      unbind p
      unbind C-z
      unbind Up
      unbind Down
      unbind Left
      unbind Right


      # pane navigation
      bind -r C-h select-pane -L
      bind -r C-j select-pane -D
      bind -r C-k select-pane -U
      bind -r C-l select-pane -R

      ## # kill pane
      ## bind "|" kill-pane
      ## bind "6|" kill-session

      ## find session
      #bind C-f command-prompt -p find-session 'switch-client -t %%'

      # split winodws
      bind n  split-window -v -c '#{pane_current_path}' -p 30
      bind v  split-window -h -c '#{pane_current_path}' -p 40

      #pane resize
      bind -r H resize-pane -L 20
      bind -r L resize-pane -R 20
      # bind -r C-p resize-pane -D 200
      # bind -r C-o resize-pane -U 15

      # toggle fuillscreen
      bind -r C-Space resize-pane -Z

      ## window navigatoin
      unbind [
      unbind ]
      bind -r [ previous-window
      bind -r ] next-window

      # copy-mode
      setw -g mode-keys vi
      bind z copy-mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'r' send -X rectangle-tggle
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel

      # buffers
      bind b list-buffers
      bind p paste-buffer

      # tab color
      setw -g window-status-current-style bg=red
      set -g status-bg black
      set -g status-fg cyan

      # When a session is destroyed swith to another active one.
      set-option -g detach-on-destroy off

      # mouse
      setw -g mouse on

      # scroll
      bind -r C-u copy-mode -u
    '';
  };
}
