#
# Fingerprint Reader
#

{ config, lib, pkgs, ... }:

{
  services = {
    fprintd.enable = true;
  };

  security = {
    pam = {
      services = {
        login.fprintAuth = true;
        xscreensaver.fprintAuth = true;
      };
    };
  };
}
