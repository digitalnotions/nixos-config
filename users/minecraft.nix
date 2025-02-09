#
# General Home-manager configuration
#

{ config, lib, pkgs, unstable, ... }:

let
  user = "minecraft";
in
{
  # Home manager modules
  imports =
    (import ./modules/shell);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # File management
      rsync
      unzip
      gzip
      unrar
      zip
      p7zip

      # Applications
      ispell
      
      # minecraft
      prismlauncher

    ];

    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;
    gpg = {
      enable = true;
      mutableKeys = true;
      mutableTrust = true;
    };
    firefox = {
      enable = true;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DontCheckDefaultBrowser = true;
        DisablePocket = true;
        SearchBar = "unified";
      };
    };
  };

  services = {
    # blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
}
