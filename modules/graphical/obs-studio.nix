# obs-studio configuration
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.alacritty;
in {
  options.modules.graphical.obs-studio.enable = mkEnableOption "obs-studio";
  config.hm = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
