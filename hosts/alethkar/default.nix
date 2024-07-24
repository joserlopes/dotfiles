# Configuration for alethkar (laptop).
{
  pkgs,
  lib,
  profiles,
  ...
}: {
  imports = with profiles; [
    virtualisation.virtual-machines
    virtualisation.docker
    graphical.firefox
    services.bluetooth
  ];
  boot.loader = {
    systemd-boot = {
      enable = true;
      # Trying not to overwhelm the boot loader.
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  # /tmp configuration
  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "80%";
    cleanOnBoot = true;
  };

  # Network Manager
  # TODO move to module
  networking = {
    networkmanager = {
      enable = true;
    };
  };
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

  # Don't shutdown when power button is short-pressed
  # Don't suspend on idle
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    IdleAction=ignore
  '';

  # GnuPG (GPG)
  programs.gnupg.agent = {
    enable = true;
    # The first time you use a key, you no longer need to enter it's password for the
    # rest of the day
    settings = {
      default-cache-ttl = 86400;
    };
  };
  hm.programs.git.signing = {
    key = "00447403FD1045B2";
    signByDefault = true;
  };

  # Specific packages for this host
  hm.home.packages = with pkgs; [
    # Arrange external displays
    arandr
    # Karaoke Game
    ultrastardx
    # GPG's interface to password input
    pinentry
    # CL utility for controlling media players
    playerctl
    # USB File Flasher
    popsicle
    # Office Suite
    libreoffice
  ];

  # Modules
  modules = {
    editors.neovim.enable = true;
    graphical = {
      enable = true;
      development.enable = true;
      vscode.enable = true;
      obs-studio.enable = true;
      autorandr.laptop.enable = true;
      programs = {
        enable = true;
        laptop = true;
      };
      qt.enable = true;
      gtk.enable = true;
      alacritty.enable = true;
      i3.enable = true;
      xournalpp.enable = true;
    };
    services = {
      syncthing.enable = true;
      kanata.enable = true;
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

  # Wayland specialisation
  # TODO: make default
  specialisation.niri.configuration = {
    imports = with profiles; [
      graphical.niri
    ];

    # Disable i3 configuration
    modules.graphical = {
      enable = lib.mkForce false;
      autorandr.laptop.enable = lib.mkForce false;
    };
  };

  specialisation.hyprland.configuration = {
    imports = with profiles; [
      graphical.hyprland
    ];

    # Disable i3 configuration
    modules.graphical = {
      enable = lib.mkForce false;
      autorandr.laptop.enable = lib.mkForce false;
    };
  };

  # Statem state version
  system.stateVersion = "24.05";
}
