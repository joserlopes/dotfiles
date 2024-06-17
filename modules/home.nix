# modules/home.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# Home manager configuration and aliases.
# Inspired by EdSwordmith and luishfonseca.
{
  pkgs,
  options,
  config,
  lib,
  user,
  userFullName,
  ...
}: let
  inherit (lib) mkAliasDefinitions mkOption types;

  mkOpt = type: default: mkOption {inherit type default;};
in {
  options = {
    hm = mkOption {type = types.attrs;};
    usr = mkOption {type = types.attrs;};

    # FIXME this is very hacky, but no idea how to get around
    my = {
      homeDirectory = mkOpt types.path "/home/${user}";
      configHome = mkOpt types.path "/home/${user}/.config";
    };
  };

  config = {
    home-manager.users.${user} = mkAliasDefinitions options.hm;
    users.users.${user} = mkAliasDefinitions options.usr;
    users.mutableUsers = false;

    usr = {
      isNormalUser = true;
      createHome = true;
      password = "1234ze!!";
      description = userFullName;
      shell = pkgs.zsh;
      extraGroups = ["wheel"];
    };

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    hm.home.username = user;
    hm.home.homeDirectory = config.my.homeDirectory;

    # Let Home Manager install and manage itself.
    hm.programs.home-manager.enable = true;

    hm.home.stateVersion = config.system.stateVersion;
  };
}