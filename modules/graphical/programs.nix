# misc GUI programs
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.modules.graphical.programs;

  discordThemeFile = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/orblazer/discord-nordic/v4.10.14/uniform/nordic.theme.css";
    hash = "sha256-Qju3KUeC18k9m/VJ3feQNvy88YnC7zMNBRI0vRKYpxY=";
  };
in {
  options.modules.graphical.programs.enable = mkEnableOption "programs";
  options.modules.graphical.programs.laptop = mkOption {
    type = types.bool;
    default = false;
    example = true;
    description = "Whether the device is a laptop or not.";
  };

  config = mkIf cfg.enable {
    hm.home.packages = with pkgs; [
      # Discord
      discord-openasar
      # Telegram
      tdesktop
      # Obsidian
      obsidian
      # Torrent client
      qbittorrent
      # VLC media player
      vlc
      # Calibre reader
      calibre
      # Better paint
      mypaint
      # Audio control
      pavucontrol
      # Gnome calculator
      gnome.gnome-calculator
      # Slack client
      slack
      # Gimp
      gimp
      # Android screen mirroring (scrcpy)
      scrcpy
      # Drawing program
      unstable.krita
      # Recording and audio editing
      unstable.audacity
      # Animated sprite editor & pixel art tool
      # aseprite
      # Tile map editor
      # tiled
      # Video editor
      kdePackages.kdenlive
    ];

    # Video player
    hm.programs.mpv.enable = true;

    # Discord configuration
    hm.xdg.configFile."discord/settings-override.json".text = builtins.toJSON {
      openasar = {
        setup = true;
        cmdPreset =
          if cfg.laptop
          then "battery"
          else "perf";
        quickstart = true;
        css = ''
          ${builtins.readFile discordThemeFile}

          .theme-dark {
            --background-primary: var(--primary-630);
            --background-secondary: var(--primary-600);
            --background-tertiary: var(--primary-700);
          }

          /* fix for broken background on server icon list */
          .wrapper__216eb {
            background-color: var(--background-primary);
            border-right: 1px solid var(--background-secondary-alt);
          }

          /* fix for other's reactions being too light */
          .reaction__4a43f {
            background: var(--background-secondary) !important;
          }
        '';
      };
      DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
      SKIP_HOST_UPDATE = true;
      MINIMIZE_TO_TRAY = false;
      OPEN_ON_STARTUP = false;
    };

    hm.xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "video/mp4" = ["vlc.desktop"];
        # mkv files
        "video/x-matroska" = ["vlc.desktop"];
        # Image files
        "image/jpeg" = ["org.gnome.Loupe.desktop"];
        "image/png" = ["org.gnome.Loupe.desktop"];
      };
    };
  };
}
