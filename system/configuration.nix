#
# Main system configuration (for all NixOS systems)
#

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./modules/cachix
    ];# ++
#    (import ../modules/desktop/virtualization);

  # Enable ZSH system wide
  programs = {
    zsh.enable = true;
  };

  security.sudo.wheelNeedsPassword = false; # I don't want to enter sudo password all the time

  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  # Define system wide fonts
  fonts.packages = with pkgs; [
    carlito
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-code-pro
    jetbrains-mono
    font-awesome
    corefonts
    nerdfonts
  ];

  # Define system wide packages
  environment = {
    localBinInPath = true;
    variables = {
      EDITOR = lib.mkDefault "nano";
      VISUAL = lib.mkDefault "nano";
    };
    systemPackages = with pkgs; [
      killall
      nano
      neofetch
      nvd
      pciutils
      usbutils
      powertop
      htop
      dig
      lsscsi
    ];
  };

  # System wide services
  services = {
    # Don't need this as it's a secondary Bluetooth manager
    # blueman.enable = true;
    printing = {
      enable = true;
    };
    avahi = {
      enable = true;
      nssmdns = true;
    };
    power-profiles-daemon = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
  
  system.stateVersion = "23.11";
}
