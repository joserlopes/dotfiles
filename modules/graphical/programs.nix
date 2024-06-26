# misc GUI programs
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.programs;
in {
  options.modules.graphical.programs.enable = mkEnableOption "programs";

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
    ];

    # Video player
    hm.programs.mpv.enable = true;

    # Bluetooth device manager
    services.blueman.enable = config.hardware.bluetooth.enable;
  };
}
