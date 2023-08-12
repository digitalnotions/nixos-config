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

      # Need Python2 for pyrit
      # (python2.withPackages(ps: with ps;
      #   [
      #     psycopg2
      #     scapy
      #     parso-0.7.1
      #   ]))
    ];
  };
}
