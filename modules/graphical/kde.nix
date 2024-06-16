# modules/graphical/dwm.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# DWM window manager and graphical environment configuration
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical;
in {
  options.modules.graphical.enable =
    mkEnableOption "KDE Plasma graphical environment";

  config = mkIf cfg.enable {
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

    services.displayManager.sddm.wayland.enable = true;
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "pt";
      variant = "";
    };

    # Configure console keymap
    console.keyMap = "pt-latin1";

    fonts.packages = with pkgs; [
      fira-code
      material-design-icons
      nerdfonts
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-cjk-sans
    ];

    # hm.services.flameshot = {
    #   enable = true;
    #   settings = {
    #     General = {
    #       disabledTrayIcon = true;
    #       savePath = "/tmp";
    #       savePathFixed = false;
    #       saveAsFileExtension = ".png";
    #       #uiColor = "${darkblue}";
    #       startupLaunch = false;
    #       antialiasingPinZoom = true;
    #       uploadWithoutConfirmation = false;
    #       predefinedColorPaletteLarge = true;
    #     };
    #   };
    # };

    # Enable redshift when X starts
    # hm.services.redshift = {
    #   enable = true;
    #   provider = "manual";
    #   latitude = 38.7436214;
    #   longitude = -9.1952226;
    # };
  };
}
