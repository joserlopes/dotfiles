# modules/system.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/RageKnify/Config
#
# System config common across all hosts
{
  inputs,
  pkgs,
  lib,
  config,
  configDir,
  ...
}: let
  inherit (builtins) toString;
  inherit (lib.my) mapModules;
in {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };

    # Lock flake registry to keep it synced with the inputs
    # i.e. used by `nix run nixpkgs#<package>`
    registry = {
      pkgs.flake = inputs.nixpkgs; # alias to nixpkgs
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };
  };
  nix.settings.trusted-users = ["root" "@wheel"];
  security.sudo.extraConfig = ''
    Defaults lecture=never
  '';

  # Every host shares the same time zone.
  # TODO perhaps set this per host
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  services.journald.extraConfig = ''
    SystemMaxUse=500M
  '';

  # dedup equal pages
  hardware.ksm = {
    enable = true;
    sleep = null;
  };
}
