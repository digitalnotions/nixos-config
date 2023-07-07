#
# Configuration specific to Tinky - Lenovo x270 Laptop
#

{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/desktop/kde/default.nix)];


  boot = {
    initrd = {
      # Setup keyfile
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
      luks = {
         devices."luks-a39a06fa-fe6a-459b-8aaf-9c0e3cf77a3c".device = "/dev/disk/by-uuid/a39a06fa-fe6a-459b-8aaf-9c0e3cf77a3c";
         devices."luks-a39a06fa-fe6a-459b-8aaf-9c0e3cf77a3c".keyFile = "/crypto_keyfile.bin";
      };
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
