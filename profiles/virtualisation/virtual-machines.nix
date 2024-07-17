# Libvirt configuration
{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
  };

  usr.extraGroups = ["libvirtd"];

  environment.systemPackages = [pkgs.virt-manager];
}
