# Niri window manager wayland
{
  pkgs,
  profiles,
  ...
}: {
  imports = with profiles; [
    graphical.fonts
  ];

  hm.wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      misc = {
        disable_hyprland_logo = true;
      };
      input = {
        kb_layout = "pt,us";
        kb_options = "";
        kb_rules = "";

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0;
      };
      bind = [
        "$mod, Return, exec, alacritty"
        "$mod, B, exec, firefox"
      ];
    };
  };
}
