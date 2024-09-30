# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e2dc7362-095a-4244-b06c-697d66142fe2";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-6b87f8a7-d983-4241-b4ee-a81c28ca2a30".device = "/dev/disk/by-uuid/6b87f8a7-d983-4241-b4ee-a81c28ca2a30";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/16FD-AD80";
      fsType = "vfat";
    };

  swapDevices = 
  [ { device = "/dev/disk/by-uuid/c20c24f4-eaf2-4fab-917d-919d10a00fe6"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;


  # Block some sites in hosts.conf
  networking.extraHosts =
    ''
      127.0.0.1 www.youtube.com
      127.0.0.1 youtube.com
      127.0.0.1 www.google.com/search
      127.0.0.1 google.com/search
      127.0.0.1 www.lego.com
      127.0.0.1 www.dailymotion.com
      127.0.0.1 www.vimeo.com
      127.0.0.1 www.wikipedia.com

    '';
      
  
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
