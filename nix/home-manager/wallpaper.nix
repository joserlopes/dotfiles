# wallpaper scripts. changes wallpapers based on time of day
{
  pkgs,
  lib,
  configDir,
  ...
}: let
  inherit (builtins) catAttrs;
  wallpapers = [
    {
      startTime = "00:00";
      path = "${configDir}/midnight-wallpaper.jpg";
    }
    {
      startTime = "06:30";
      path = "${configDir}/morning-wallpaper.jpg";
    }
    {
      startTime = "14:00";
      path = "${configDir}/noon-wallpaper.jpg";
    }
    {
      startTime = "19:30";
      path = "${configDir}/night-wallpaper.jpg";
    }
  ];
  wallpaperScript = pkgs.writers.writeBash "setbg" ''
    now=$(${pkgs.coreutils}/bin/date +%s)
    ${lib.strings.concatMapStringsSep "\n" (wallpaper: ''
        if [[ `${pkgs.coreutils}/bin/date --date='${wallpaper.startTime}' +%s` -le "$now" ]]; then
          chosen_wallpaper='${wallpaper.path}'
        fi
      '')
      wallpapers}

    if [ -n "$chosen_wallpaper" ]; then
      ${pkgs.feh}/bin/feh --bg-fill --no-fehbg "$chosen_wallpaper"
    fi
  '';
in {
  systemd.user.services.set-wallpaper = {
    Unit = {
      Description = "Set desktop background using feh";
      After = ["graphical-session-pre.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${wallpaperScript}";
      IOSchedulingClass = "idle";
    };

    Install = {WantedBy = ["graphical-session.target"];};
  };
  systemd.user.timers.set-wallpaper = {
    Unit = {Description = "Set desktop background using feh";};

    Timer = {
      OnCalendar = catAttrs "startTime" wallpapers;
      Persistent = true;
    };

    Install = {WantedBy = ["timers.target"];};
  };
}
