#
# General Home-manager configuration
#

{ config, lib, pkgs, unstable, ... }:

let
  user = "mwood";
in
{
  # Home manager modules
  imports =
    (import ./modules/editors) ++
    (import ./modules/shell) ++
    [(import ./modules/security/default.nix)];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with unstable; [
      # File management
      rsync
      unzip
      gzip
      unrar
      zip
      p7zip
      discord

      # Applications
      ispell
      obsidian
      pandoc
      tetex
      rpi-imager
      
      # Terminal
      kitty
      # alacritty
      thefuck

      # Programming
      (python3.withPackages(ps: with ps;
        [
          requests
          beautifulsoup4
          flake8
        ]))

      # Open GL
      glxinfo
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
    nix-index = {
      enable = true;
      enableZshIntegration = true;
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
    gpg-agent = {
      enable = true;
      pinentryFlavor = "qt";
#      extraConfig = ''
#        allow-emacs-pinentry
#        allow-loobpack-pinentry
      #     '';
      extraConfig = ''
        allow-emacs-pinentry
     '';                        

    };
  };
}
