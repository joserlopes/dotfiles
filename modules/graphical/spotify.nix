# Spotify configuration and themeing with Spicetify
{
  config,
  lib,
  spicetifyPkgs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.modules.graphical.programs;
in {
  # Follow graphical.programs.enabled
  config.hm = mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      theme = spicetifyPkgs.themes.Comfy;

      enabledExtensions = with spicetifyPkgs.extensions; [
        fullAppDisplay
        autoSkipVideo
        shuffle # shuffle+
        hidePodcasts
      ];

      enabledCustomApps = with spicetifyPkgs.apps; [lyrics-plus];
    };
  };
}
