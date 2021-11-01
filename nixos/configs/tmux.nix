{ pkgs, ... }:
{
  programs.tmux = {
    terminal = "xterm-256color";
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    secureSocket = false;
    shortcut = "a";
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    historyLimit = 30000;
    extraConfig = ''
    # Add truecolor support
set-option -ga terminal-overrides ",xterm-256color:Tc"
# Default terminal is 256 colors
set -g default-terminal "screen-256color"
# faster repetition (default 500 ms)
set -s escape-time 0

#disabling the mouse
set -g mouse on

# ctrl A (rebinding the prefix key)
set-option -g prefix C-a
unbind-key C-b
bind-key C-a send-prefix

# split panes using | and - (rebinding the pane key to something that makes sense)
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %
    # Since we are Vim users lets configure using the vim keys
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Allows for hot reloads 
bind r source-file ~/.tmux.conf

# Enable vi keys.
setw -g mode-keys vi

# Escape turns on copy mode
bind Escape copy-mode

# v in copy mode starts making selection
bind-key -T copy-mode v send -X begin-selection
bind-key -T copy-mode y send -X copy-selection

# make Prefix p paste the buffer.
unbind p
bind p paste-buffer
    # Changing the theme of tmux
# Set status bar on
set -g status on
    # tmux messages are displayed for 4 seconds
set -g display-time 4000
# Update the status line every second
set -g status-interval 5

# Set the position of window lists.
set -g status-justify centre # [left | centre | right]
    # Set the status bar position
set -g status-position top # [top, bottom]

# Set status bar background and foreground color.
#set -g status-style fg=colour136,bg="#002b36"


# Set left side status bar length and style
set -g status-left-length 60
set -g status-left-style default

# Display the session name
set -g status-left "#[fg=green] ❐  #S #[default]"

# Display the os version (Mac Os)
set -ag status-left " #[fg=black] #[fg=magenta,bright] #(lsb_release -ds || cat /etc/*release || uname -om ) #[default]"

# Display the internet speed
#set -g status-left '📡#{prefix_highlight} #{network_speed} #[default]'

# Set right side status bar length and style
set -g status-right-length 140
set -g status-right-style default

# Display the cpu load (Linux)
set -g status-right "#[fg=green]#($TMUX_PLUGIN_MANAGER_PATH/tmux-mem-cpu-load/tmux-mem-cpu-load --colors --powerline-right --interval 2)#[default]"

# Display the date
set -ag status-right "#[fg=white,bg=default]  %a %d #[default]"

# Display the time
set -ag status-right "#[fg=colour172,bright,bg=default] ⌚︎%l:%M %p #[default]"

# Display the hostname
set -ag status-right "#[fg=cyan,bg=default] #H #[default]"

# Set the inactive window color and style
#set -g window-status-style fg=colour244,bg=default
#set -g window-status-format ' #I #W '

# Set the active window color and style
#set -g window-status-current-style fg=black,bg=colour136
#set -g window-status-current-format ' #I #W '
#set -g pane-border-style 'fg=colour19 bg=colour0'
# Changing how the active pane works

# Colors for pane borders(default)
#setw -g pane-border-style fg=green,bg=black
#setw -g pane-active-border-style fg=white,bg=black

# Active pane normal, other shaded out
#setw -g window-style fg=colour240,bg=colour235
#setw -g window-active-style fg=white,bg=black

# nova
set -g @nova-nerdfonts true
set -g @nova-theme "dracula" #nord
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      #nova
      cpu
    ];
  };
}
