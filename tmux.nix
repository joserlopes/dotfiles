{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  # basic configuration of git, please change to your own
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    historyLimit = 100000;
    terminal = "tmux-256color";
    extraConfig = ''
      set -g mouse on

      # Set prefix
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Start windows and panes at 1 not 0
      set -g base-index 1
      set -g pane-base-index 1
      set -g status-position bottom
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # set vi-mode
      set-window-option -g mode-keys vi

      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Making end and home keys work on Tmux
      bind-key -n Home send Escape "OH"
      bind-key -n End send Escape "OF"
      bind-key C-l send-keys "C-l"

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
