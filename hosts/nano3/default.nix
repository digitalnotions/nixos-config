#
# Configuration specific to Nano3 - Lenovo Carbon X1 Nano Gen 3
#

{ config, lib, pkgs, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
#    [(import ../../modules/hardware/fingerprint.nix)] ++
    [(import ../../modules/desktop/kde/default.nix)] ++
    [(import ../../system/modules/desktop/video/default.nix)];

  # Webcam software for MIPI webcam
  hardware.ipu6 = {
    enable = true;
    platform = "ipu6ep";
  };
  hardware.firmware = [
    pkgs.ivsc-firmware
  ];

  networking = {
    hostName = "nano3";
    networkmanager.enable = true;
  };

  # Taken from https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/intel/default.nix
  boot.initrd.kernelModules = [ "i915" ];

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

  hardware.opengl.extraPackages = with pkgs; [
    (if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11") then vaapiIntel else intel-vaapi-driver)
    libvdpau-va-gl
    intel-media-driver
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Use the latest linux kernel

    #kernelPackages = pkgs.linuxPackages_6_6;
    #kernelPackages = pkgs.linuxPackages_latest;
  };
}
