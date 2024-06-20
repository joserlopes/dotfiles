# hosts/bacchus/configuration.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# Configuration for bacchus (PC).
{pkgs, ...}: {
  # Bootloader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/disk/by-uuid/8751-786B";
  # boot.loader.grub.useOSProber = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    # Arrange external displays
    arandr
    # Karaoke Game
    ultrastardx
  ];

  # Modules
  modules = {
    editors.neovim.enable = true;
    graphical = {
      enable = true;
      development.enable = true;
      autorandr.laptop.enable = true;
      programs.enable = true;
      qt.enable = true;
      gtk.enable = true;
      alacritty.enable = true;
      i3.enable = true;
    };
    services = {
      syncthing.enable = true;
    };
    shell = {
      git.enable = true;
      lf.enable = true;
      tmux.enable = true;
      starship.enable = true;
      zsh.enable = true;
    };
    personal.enable = true;
    xdg.enable = true;
    ist.enable = true;
  };

  # Statem state version
  system.stateVersion = "24.05";
}
