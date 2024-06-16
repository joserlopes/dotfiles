# hosts/bacchus/configuration.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# Configuration for bacchus (PC).
{
  pkgs,
  lib,
  sshKeys,
  config,
  user,
  ...
}: {
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # /tmp configuration
  # boot.tmp = {
  #   useTmpfs = true;
  #   tmpfsSize = "80%";
  #   cleanOnBoot = true;
  # };

  # Network Manager
  # TODO move to module
  networking.networkmanager.enable = true;
  usr.extraGroups = ["networkmanager"];

  # SSH server
  # TODO move to module
  services.openssh = {
    enable = true;
    ports = [22];
  };

  # Audio
  # TODO move to module
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Don't shutdown when power button is short-pressed
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  # Docker (containers)
  virtualisation.docker.enable = true;

  hardware.opengl.enable = true;

  # GnuPG (GPG)
  hm.programs.gpg.enable = true;
  hm.services.gpg-agent.enable = true;
  # hm.programs.git.signing = {
  #   key = "ED93476ECCA9DE46";
  #   signByDefault = true;
  # };

  # Specific packages for this host
  hm.home.packages = with pkgs; [
    # Karaoke Game
    ultrastardx
  ];

  # Modules
  modules = {
    editors.neovim.enable = true;
    graphical = {
      enable = true;
      development.enable = true;
      programs.enable = true;
      # gtk.enable = true;
      # qt.enable = true;
      alacritty.enable = true;
    };
    services.syncthing.enable = true;
    shell = {
      git.enable = true;
      lf.enable = true;
      tmux.enable = true;
      starship.enable = true;
      zsh.enable = true;
    };
    personal.enable = true;
    xdg.enable = true;
  };

  # Statem state version
  system.stateVersion = "24.05";
}
