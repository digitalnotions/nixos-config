{ pkgs, lib, config, ... }:

with lib;
{

  nix = {
   extraOptions = "experimental-features = nix-command flakes";
   gc = {
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 20d";
   };
   settings = {
     auto-optimise-store = true;
   };
  };
  nixpkgs.config.allowUnFree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Set your time zone
  time.timeZone = "America/New_York";

  # Enable networking
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set default shell to be dash for speed
  # Apparently this is bad because a lot of nix relies on bash
  # environment.binsh = "${pkgs.dash}/bin/dash";
  environment.homeBinInPath = true;
  # programs.fish.enable = true;
  programs.zsh.enable = true;

}

