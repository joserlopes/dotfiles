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
      userDirs = {
        enable = true;
        desktop = "${config.my.homeDirectory}/Desktop";
        documents = "${config.my.homeDirectory}/Documents";
        download = "${config.my.homeDirectory}/Downloads";
        music = "${config.my.homeDirectory}/Music";
        pictures = "${config.my.homeDirectory}/Pictures";
        publicShare = "${config.my.homeDirectory}/Public";
        templates = "${config.my.homeDirectory}/Templates";
        videos = "${config.my.homeDirectory}/videos";
      };
      configFile."mimeapps.list".force = true;
      configHome = "${config.my.homeDirectory}/.config";
    };
  };
}
