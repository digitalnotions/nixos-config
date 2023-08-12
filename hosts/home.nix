#
# General Home-manager configuration
#

{ config, lib, pkgs, unstable, user, ... }:

{
  # Home manager modules
  imports =
    (import ../modules/editors) ++
    (import ../modules/shell) ++
    [(import ../modules/security/default.nix)];

  home = {
    username = "mwood";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
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
      firefox
      obsidian
      pandoc
      tetex

      # Terminal
      kitty
      alacritty
      thefuck

      # Programming
      (python3.withPackages(ps: with ps;
        [
          requests
          flake8
        ]))
    ];

    stateVersion = "23.05";
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
