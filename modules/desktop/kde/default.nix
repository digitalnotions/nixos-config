#
# KDE Plasma 5 Configuration
#

{ config, lib, pkgs, ... }:

{
  programs = {
    dconf.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      displayManager = {
        sddm.enable = true;
      };
      desktopManager = {
        plasma5 = {
          enable = true;
          excludePackages = with pkgs.libsForQt5; [
            khelpcenter
            konsole
          ];
        };
      };
    };
  };
}
