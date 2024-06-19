# modules/xdg.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# XDG home configuration
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.xdg;
in {
  options.modules.xdg.enable = mkEnableOption "xdg";

  # Home manager module
  config.hm = mkIf cfg.enable {
    xdg = {
      enable = true;
      configFile."mimeapps.list".force = true;
      configHome = "${config.my.homeDirectory}/.config";
    };
  };
}
