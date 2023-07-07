{ config, pkgs, user, ... }:

{
  users.groups.libvirtd.members = [ "root" "${user}" ];

  virtualisation = {
    libvirtd.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      qemu
      qemu_kvm
      qemu-utils
      libvirt
      virt-manager
      bridge-utils
    ];
  };
}
