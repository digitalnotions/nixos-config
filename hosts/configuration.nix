#
# Main system configuration (for all NixOS systems)
#

{ config, lib, pkgs, inputs, user, ... }:

{
  imports =
    [../modules/cachix] ++
    (import ../modules/desktop/virtualization);

  users.users.${user} = {
    isNormalUser = true;
    description = "Mark Wood";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.zsh;
  };

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
  fonts.fonts = with pkgs; [
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
      EDITOR = "emacsclient -t";
      VISUAL = "emacsclient -c";
    };
    systemPackages = with pkgs; [
      killall
      cachix
      nano
      neofetch
      nvd
      pciutils
      usbutils
      powertop
      htop
      gcc
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
    syncthing = {
      enable = true;
      dataDir = "/home/${user}/";
      user = "${user}";
      openDefaultPorts = true;
      configDir = "/home/${user}/.config/syncthing";
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
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 20d";
    };
    settings = {
      auto-optimise-store = true;
    };
#   package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
  nixpkgs.config.allowUnFree = true;

  system.stateVersion = "23.05";
}
