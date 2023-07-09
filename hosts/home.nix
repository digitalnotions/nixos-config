#
# General Home-manager configuration
#

{ config, lib, pkgs, unstable, user, ... }:

{
  # Home manager modules
  imports =
    (import ../modules/editors) ++
    (import ../modules/shell);

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

      # Applications
      ispell
      firefox
      obsidian

      # Terminal
      kitty
      alacritty
      thefuck

      # Programming
      (python3.withPackages(ps: with ps; [ requests flake8 ]))
    ];

    stateVersion = "23.05";
  };

  programs = {
    home-manager.enable = true;
  };

  services = {
    # blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
}
