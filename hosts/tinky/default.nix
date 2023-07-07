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
        devices."luks-dda54615-0966-4d27-9a86-6641200f2b63".device = "/dev/disk/by-uuid/dda54615-0966-4d27-9a86-6641200f2b63";
        devices."luks-dda54615-0966-4d27-9a86-6641200f2b63".keyFile = "/crypto_keyfile.bin";
      };
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
