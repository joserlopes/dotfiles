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
    };
  };
}
