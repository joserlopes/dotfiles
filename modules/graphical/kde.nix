# KDE Plasma Desktop environment
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

    environment.plasma6.excludePackages = with pkgs; [
      kdePackages.kwallet
      kdePackages.kwalletmanager
      kwalletmanager
    ];

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "pt";
      variant = "";
    };

    # Configure console keymap
    console.keyMap = "pt-latin1";
  };
}
