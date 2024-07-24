# kanata keyboard key customizer configuration
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.services.kanata;
in {
  options.modules.services.kanata.enable = mkEnableOption "kanata";

  config = mkIf cfg.enable {
    services.kanata = {
      enable = true;
      # Replace CapsLock with esc on tap and left ctrl on hold.
      keyboards = {
        internalKeyboard = {
          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defsrc
             caps
            )

            (defvar
             tap-time 150
             hold-time 200
            )

            (defalias
             caps (tap-hold 100 100 esc lctl)
            )

            (deflayer base
             @caps
            )
          '';
        };
        externalKeyboard = {
          devices = [
            "/dev/input/by-path/pci-0000:00:14.0-usb-0:4:1.0-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defsrc
             caps
            )

            (defvar
             tap-time 150
             hold-time 200
            )

            (defalias
             caps (tap-hold 100 100 esc lctl)
            )

            (deflayer base
             @caps
            )
          '';
        };
      };
    };
    # User needs to be added to this group, so that the service can run without
    # sudo privileges
    usr.extraGroups = ["uinput"];
  };
}
