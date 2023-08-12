#
# Personal Emacs configuration
#

{ config, pkgs, lib, ... }:

{

  home = {
    packages = with pkgs; [
      # Wifi auditing
      aircrack-ng
      wirelesstools
      wifite2
      iw
      macchanger
    ];
  };
}
