#
# Configuration specific to Tinky - Lenovo x270 Laptop
#

{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
#    [(import ../../modules/hardware/fingerprint.nix)] ++
    [(import ../../modules/desktop/kde/default.nix)] ++
    [(import ../../modules/desktop/video/default.nix)];


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
