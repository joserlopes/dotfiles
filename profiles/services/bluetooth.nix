{
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # Bluetooth device manager
  services.blueman.enable = true;
}
