# i3 window manager and graphical environment configuration
{
  pkgs,
  config,
  lib,
  configDir,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical;
  ws1 = "1: Browser";
  ws2 = "2: Editor";
  ws3 = "3: Notes";
  ws4 = "4: Docs";
  ws5 = "5: Statement";
  ws6 = "6: Nemo";
  ws7 = "7: Books";
  ws8 = "8: Rhythmbox";
  ws9 = "9: KeePass";
  ws10 = "10";
  mode_system = "System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown";
in {
  options.modules.graphical.i3.enable =
    mkEnableOption "i3 window manager";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
      cinnamon.nemo-with-extensions
      networkmanagerapplet
    ];

    hm.home.packages = with pkgs; [
      (writeShellScriptBin "tmux-sessionizer" (builtins.readFile ../../config/scripts/tmux-sessionizer))
      (writeShellScriptBin "URL" (builtins.readFile ../../config/scripts/URL))
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
      windowManager.i3.enable = true;
      xkb = {
        layout = "pt";
        variant = "";
      };
    };

    hm.xsession.windowManager.i3 = {
      enable = true;
      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "rofi -show combi -icon-theme Papirus -show-icons";
        window.titlebar = false;
        defaultWorkspace = "workspace number ${ws1}";
        startup = [
          {command = "nm-applet";}
          {command = "dropbox";}
          {command = "brave";}
          {command = "alacritty";}
        ];
        floating.modifier = "${modifier}";
        modes = {
          resize = {
            Down = "resize grow height 10 px or 10 ppt";
            Escape = "mode default";
            Left = "resize shrink width 10 px or 10 ppt";
            Return = "mode default";
            Right = "resize grow width 10 px or 10 ppt";
            Up = "resize shrink height 10 px or 10 ppt";
          };
          "${mode_system}" = {
            "l" = "exec i3lock --ignore-empty-password --tiling -i ~/dotfiles/config/wallpapers/lock.png 2>/dev/null, mode default";
            "e" = "exec --no-startup-id i3-msg exit, mode default";
            "s" = "exec --no-startup-id $Locker && systemctl suspend, mode default";
            "h" = "exec --no-startup-id $Locker && systemctl hibernate, mode default";
            "r" = "exec --no-startup-id systemctl reboot, mode default";
            "Shift+s" = "exec --no-startup-id systemctl poweroff -i, mode default";

            # back to normal: Enter or Escape
            "Return" = "mode default";
            "Escape" = "mode default";
          };
        };

        # Use lib.mkOptionDefault if you want to keep the original keymaps
        keybindings = lib.mkOptionDefault {
          # Adjust screen brightness
          "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";

          # Same keymaps as above but fore keyboards without special keys
          "Mod1+Shift+plus" = "exec brightnessctl set 5%+";
          "Mod1+Shift+minus" = "exec brightnessctl set 5%-";

          # Use pactl to adjust volume in PulseAudio.
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume 0 +5%"; #increase sound volume"
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume 0 -5%"; #decrease sound volume
          "XF86AudioMute" = "exec pactl set-sink-mute 0 toggle";
          "XF86AudioMicMute" = "exec pactl set-source-mute 0 toggle";

          # Same keymaps as above but fore keyboards without special keys
          "Mod1+plus" = "exec pactl set-sink-volume 0 +5%"; #increase sound volume
          "Mod1+minus" = "exec pactl set-sink-volume 0 -5%"; #decrease sound volume
          "Mod1+m" = "exec pactl set-sink-mute 0 toggle";
          "Mod1+Shift+m" = "exec pactl set-source-mute 0 toggle";

          # Use playerctl to handle media keys
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPause" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";

          # Same keymaps as above but fore keyboards without special keys
          "Mod1+p" = "exec playerctl play-pause";
          "Mod1+Shift+p" = "exec playerctl play-pause";
          "Mod1+n" = "exec playerctl next";
          "Mod1+Shift+n" = "exec playerctl previous";

          # launch obsidian
          "${modifier}+o" = "exec obsidian";

          # launch brave
          "${modifier}+b" = "exec brave";

          # launch file explorer
          "${modifier}+n" = "exec nemo";

          # kill focused window
          "${modifier}+q" = "kill";

          # change focus
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+ccedilla" = "focus left";

          # alternatively, you can use the cursor keys:
          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          # move focused window
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
          "${modifier}+Shift+ccedilla" = "move left";

          # alternatively, you can use the cursor keys:
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          # split in horizontal orientation
          "${modifier}+h" = "split h";

          # split in vertical orientation
          "${modifier}+v" = "split v";

          # enter fullscreen mode for the focused container
          "${modifier}+f" = "fullscreen toggle";

          # change container layout (stacked, tabbed, toggle split)
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          # toggle tiling / floating
          "${modifier}+Shift+space" = "floating toggle";

          # change focus between tiling / floating windows
          "${modifier}+space" = "focus mode_toggle";

          # focus the parent container
          "${modifier}+a" = "focus parent";

          # switch to workspace
          "${modifier}+1" = "workspace number ${ws1}";
          "${modifier}+2" = "workspace number ${ws2}";
          "${modifier}+3" = "workspace number ${ws3}";
          "${modifier}+4" = "workspace number ${ws4}";
          "${modifier}+5" = "workspace number ${ws5}";
          "${modifier}+6" = "workspace number ${ws6}";
          "${modifier}+7" = "workspace number ${ws7}";
          "${modifier}+8" = "workspace number ${ws8}";
          "${modifier}+9" = "workspace number ${ws9}";
          "${modifier}+0" = "workspace number ${ws10}";

          # move focused container to workspace
          "${modifier}+Shift+1" = "move container to workspace number ${ws1}";
          "${modifier}+Shift+2" = "move container to workspace number ${ws2}";
          "${modifier}+Shift+3" = "move container to workspace number ${ws3}";
          "${modifier}+Shift+4" = "move container to workspace number ${ws4}";
          "${modifier}+Shift+5" = "move container to workspace number ${ws5}";
          "${modifier}+Shift+6" = "move container to workspace number ${ws6}";
          "${modifier}+Shift+7" = "move container to workspace number ${ws7}";
          "${modifier}+Shift+8" = "move container to workspace number ${ws8}";
          "${modifier}+Shift+9" = "move container to workspace number ${ws9}";
          "${modifier}+Shift+0" = "move container to workspace number ${ws10}";

          "${modifier}+Shift+q" = "mode \"${mode_system}\"";

          "Print" = "exec --no-startup-id flameshot gui";
          "${modifier}+Shift+p" = "exec --no-startup-id flameshot gui";

          "${modifier}+m" = "move workspace to output next";
        };
        bars = [
          {
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
            fonts = {
              names = ["pango:DejaVuSansM Nerd Font Mono"];
              size = 13.0;
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
      extraConfig = ''
        for_window [class="^.*"] border pixel 2
        for_window [class="^.*"] client.focused          #77dd77 #285577 #ffffff #2e9ef4   #285577
      '';
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

    hm.programs.rofi = {
      enable = true;
      # package = pkgs.rofi-wayland;
      terminal = "${pkgs.alacritty}/bin/alacritty";
      theme = ../../config/theme.rasi;
      extraConfig = {
        combi-modi = "URL:URL,drun";
        modi = "combi";
      };
    };

    hm.services.picom = {
      enable = true;
      # backend = "glx";
      # vSync = true;
      # settings = {unredir-if-possible = false;};
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

    programs.nm-applet.enable = true;
  };
}
