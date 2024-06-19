# modules/system.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/RageKnify/Config
#
# System config common across all hosts
{
  inputs,
  pkgs,
  ...
}: {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
    };

    # Lock flake registry to keep it synced with the inputs
    # i.e. used by `nix run nixpkgs#<package>`
    registry = {
      pkgs.flake = inputs.nixpkgs; # alias to nixpkgs
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };

    nixPath = [
      "nixpkgs=/etc/channels/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };
  environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;

  security.sudo.extraConfig = ''
    Defaults lecture=never
  '';

  # Time zone
  time.timeZone = null;
  services.automatic-timezoned.enable = true;

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
