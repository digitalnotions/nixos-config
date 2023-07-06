{ pkgs, lib, config, ... }:

with lib;
{

  environment.systemPackages = with pkgs; [
    kitty
    firefox
    thefuck
    partition-manager
    (python3.withPackages(ps: with ps; [ requests flake8 ]))
    obsidian

    # Windows Virtual machine
    qemu
    qemu_kvm
    qemu-utils
    libvirt
    virt-manager
    bridge-utils
  ];

}
