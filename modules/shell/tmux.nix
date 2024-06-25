# modules/home/shell/tmux.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# tmux configuration (Based on RageKnify's)
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.shell.tmux;
in {
  options.modules.shell.tmux.enable = mkEnableOption "tmux";

  # Home manager module
  config.hm = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      historyLimit = 100000;
      clock24 = true;
      customPaneNavigationAndResize = true;
      keyMode = "vi";
      terminal =
        if config.modules.graphical.programs.enable
        then "alacritty"
        else "tmux-256color";
      prefix = "C-Space";
      mouse = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        battery
        yank
        tmux-fzf
        resurrect
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
          '';
        }
      ];
      extraConfig = ''
        set -ag terminal-overrides ",xterm-256color:RGB"

        # Shift Alt vim keys to switch windows
        bind -n M-H previous-window
        bind -n M-L next-window

        # Start windows and panes at 1 not 0
        set -g base-index 1
        set -g pane-base-index 1
        set -g status-position bottom
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

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

        source-file ~/dotfiles/modules/shell/tmux-everforest-dark-medium.conf
      '';
    };
  };
}
