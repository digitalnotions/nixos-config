#
# Configuration specific to Tinky - Lenovo x270 Laptop
#

{ config, pkgs, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
#    [(import ../../modules/hardware/fingerprint.nix)] ++
    [(import ../../modules/desktop/kde/default.nix)] ++
    [(import ../../system/modules/desktop/video/default.nix)];


  networking = {
    hostName = "nano";
    networkmanager.enable = true;
  };
  
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD";};
  
  boot = {
    initrd = {
      # Setup keyfile
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
