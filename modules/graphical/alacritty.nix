{...}: {
  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      window.opacity = 0.80;
      font = {
        size = 16;
        bold = {
          family = "JetBrainsMonoNL Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMonoNL Nerd Font";
          style = "Italic";
        };
        normal = {
          # family = "JetBrainsMonoNL Nerd Font";
          family = "0xProto Nerd Font";
          style = "regular";
        };
      };
      keyboard.bindings = [
        {
          key = "F11";
          action = "ToggleFullScreen";
        }
      ];
      colors = {
        primary = {
          background = "#2d353b";
          foreground = "#d3c6aa";
        };
        normal = {
          black = "#475258";
          red = "#e67e80";
          green = "#a7c080";
          yellow = "#dbbc7f";
          blue = "#7fbbb3";
          magenta = "#d699b6";
          cyan = "#83c092";
          white = "#d3c6aa";
        };
        bright = {
          black = "#475258";
          red = "#e67e80";
          green = "#a7c080";
          yellow = "#dbbc7f";
          blue = "#7fbbb3";
          magenta = "#d699b6";
          cyan = "#83c092";
          white = "#d3c6aa";
        };
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}
