# Configuration for alethkar (laptop).
{pkgs, ...}: {
  boot.loader = {
    systemd-boot = {
      enable = true;
      # Trying not to overwhelm the boot loader.
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  # /tmp configuration
  # boot.tmp = {
  #   useTmpfs = true;
  #   tmpfsSize = "80%";
  #   cleanOnBoot = true;
  # };

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

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # Don't shutdown when power button is short-pressed
  # Don't suspend on idle
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    IdleAction=ignore
  '';

  # Docker (containers)
  virtualisation.docker.enable = true;

  hardware.opengl.enable = true;

  # # Load nvidia driver for Xorg and Wayland
  # services.xserver.videoDrivers = ["nvidia"];
  #
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #
  #   # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
  #   # Enable this if you have graphical corruption issues or application crashes after waking
  #   # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
  #   # of just the bare essentials.
  #   powerManagement.enable = false;
  #
  #   # Fine-grained power management. Turns off GPU when not in use.
  #   # Experimental and only works on modern Nvidia GPUs (Turing or newer).
  #   powerManagement.finegrained = false;
  #
  #   # Use the NVidia open source kernel module (not to be confused with the
  #   # independent third-party "nouveau" open source driver).
  #   # Support is limited to the Turing and later architectures. Full list of
  #   # supported GPUs is at:
  #   # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
  #   # Only available from driver 515.43.04+
  #   # Currently alpha-quality/buggy, so false is currently the recommended setting.
  #   open = false;
  #
  #   # Enable the Nvidia settings menu,
  #   # accessible via `nvidia-settings`.
  #   nvidiaSettings = true;
  #
  #   # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };

  # GnuPG (GPG)
  programs.gnupg.agent.enable = true;
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
