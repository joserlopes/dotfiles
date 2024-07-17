# Autorandr configuration for laptops
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.autorandr;
in {
  options.modules.graphical.autorandr.laptop.enable =
    mkEnableOption "autorandr laptop configuration";

  config = mkIf cfg.laptop.enable {
    services.autorandr = {
      enable = true;
      defaultTarget = "laptop";
      profiles = {
        laptop = {
          fingerprint = {"eDP-1-1" = "*";};
          config = {
            eDP-1-1 = {
              enable = true;
              primary = true;
              mode = "1920x1080";
              position = "0x0";
              rotate = "normal";
            };
          };
        };
        # Dual monitor profile: HDMI on the bottom right of eDP
        laptop-dual = {
          fingerprint = {
            "eDP-1-1" = "*";
            "HDMI-0" = "*";
          };
          config = {
            HDMI-0 = {
              enable = true;
              primary = false;
              mode = "1920x1080";
              position = "1920x1080";
              rotate = "normal";
            };
            eDP-1-1 = {
              enable = true;
              primary = true;
              mode = "1920x1080";
              position = "0x0";
              rotate = "normal";
            };
          };
        };
      };
    };
  };
}
