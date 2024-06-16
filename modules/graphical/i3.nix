# i3 window manager and graphical environment configuration
{
  pkgs,
  config,
  lib,
  configDir,
  user,
  ...
}: let
  inherit (lib) mkEnableOption mkIf escapeShellArg;
  cfg = config.modules.graphical;
in {
  options.modules.graphical.i3.enable =
    mkEnableOption "i3 window manager";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rofi
    ];

    fonts.packages = with pkgs; [
      fira-code
      nerdfonts
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-cjk-sans
    ];

    services.xserver = {
      enable = true;
      xkb = {
        layout = "pt";
        variant = "";
      };
      autorun = true;
    };

    hm.xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";
        bars = [
          {
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
            fonts = {
              names = ["pango:DejaVu Sans Mono Font Awesome 6 Free"];
              size = 15.0;
            };
            colors = {
              separator = "#666666";
              background = "#222222";
              statusline = "#dddddd";
              focusedWorkspace = {
                background = "#0088CC";
                border = "#0088CC";
                text = "#ffffff";
              };
              activeWorkspace = {
                background = "#333333";
                border = "#333333";
                text = "#ffffff";
              };
              inactiveWorkspace = {
                background = "#333333";
                border = "#333333";
                text = "#888888";
              };
              urgentWorkspace = {
                background = "#2f343a";
                border = "#900000";
                text = "#ffffff";
              };
            };
          }
        ];
      };
    };

    hm.programs.i3status-rust = {
      enable = true;
      bars = {
        top = {
          theme = "gruvbox-dark";
          icons = "material-nf";
          blocks = [
            {
              block = "focused_window";
              format = {
                full = " $title.str(max_w:20) |";
                short = " $title.str(max_w:10) |";
              };
            }
            {
              block = "disk_space";
              path = "~/";
              info_type = "available";
              alert_unit = "GB";
              interval = 20;
              warning = 20.0;
              alert = 10.0;
              format = " $icon nixos: $available.eng(w:2) ";
              click = [
                {
                  # On click open nemo file manager
                  button = "left";
                  cmd = "nemo";
                }
              ];
            }
            {
              block = "music";
              format = " $icon {$combo.str(max_w:20, rot_interval:0.5) $prev $play $next |} ";
              format_alt = " $icon ";
              seek_step_secs = 10;
            }
            {
              block = "sound";
              click = [
                {
                  button = "left";
                  cmd = "pavucontrol";
                }
              ];
            }
            {
              block = "sound";
              device_kind = "source";
              click = [
                {
                  button = "left";
                  cmd = "pavucontrol";
                }
              ];
            }
            {
              block = "time";
              interval = 5;
              format = " $icon $timestamp.datetime(f:'%a %d/%m/%Y %H:%M:%S') ";
            }
            {
              block = "bluetooth";
              mac = "74:45:CE:10:A7:1A";
              disconnected_format = "";
              format = " $icon $name $percentage ";
              battery_state = {
                "0..20" = "critical";
                "21..70" = "warning";
                "71..100" = "good";
              };
              click = [
                {
                  button = "left";
                  cmd = "blueman-manager";
                }
              ];
            }
            {
              block = "bluetooth";
              mac = "28:06:DE:00:05:8A";
              disconnected_format = "";
              format = " $icon $name $percentage ";
              battery_state = {
                "0..20" = "critical";
                "21..70" = "warning";
                "71..100" = "good";
              };
              click = [
                {
                  button = "left";
                  cmd = "blueman-manager";
                }
              ];
            }
            {
              block = "battery";
              format = " $icon $percentage {$time |}";
            }
            {
              block = "backlight";
              format = " $icon $brightness";
              missing_format = "";
            }
            {
              block = "hueshift";
              hue_shifter = "redshift";
              format = " $temperature ";
              step = 50;
              click_temp = 3500;
            }
            {
              block = "net";
              format = " $icon {$signal_strength $ssid |Wired connection}";
              click = [
                {
                  button = "left";
                  cmd = "nm-connection-editor";
                }
              ];
            }
          ];
        };
      };
    };

    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        middleEmulation = false;
      };
    };

    hm.services.picom = {
      enable = true;
      backend = "glx";
      vSync = true;
      settings = {unredir-if-possible = false;};
    };

    hm.services.flameshot = {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          savePath = "/tmp";
          savePathFixed = false;
          saveAsFileExtension = ".png";
          # uiColor = "${lib.my.colors.lightblue}";
          startupLaunch = false;
          antialiasingPinZoom = true;
          uploadWithoutConfirmation = false;
          predefinedColorPaletteLarge = true;
        };
      };
    };

    # Clipboard manager
    hm.services.clipmenu.enable = true;

    # Notification daemon
    hm.services.dunst = {
      enable = true;
      configFile = configDir + "/dunstrc";
    };

    # Enable redshift when X starts
    hm.services.redshift = {
      enable = true;
      provider = "manual";
      latitude = 38.7436214;
      longitude = -9.1952226;
    };
  };
}
