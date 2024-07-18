# GTK theme configuration
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.gtk;
in {
  options.modules.graphical.gtk.enable = mkEnableOption "gtk";

  config = mkIf cfg.enable {
    programs.dconf.enable = true;

    hm.gtk = {
      enable = true;

      theme = {
        package = pkgs.nordic;
        name = "Nordic-darker";
      };

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
    };
  };
}
