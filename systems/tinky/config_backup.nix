# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, callPackage,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../cachix/default.nix
      ../../pkgs/base-packages.nix
      ../../pkgs/desktop-packages.nix
      ../../modules/base.nix
      ../../modules/desktop.nix
    ];

  boot.initrd = {
    secrets = {
      # Setup keyfile
      "/crypto_keyfile.bin" = null;
    };
#    kernelModules = [ "i915" ];
  };

#  boot.kernelParams = [ "i915.enable_psr=0" ];

#  nixpkgs.config.packageOverrides = pkgs: {
#    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
#  };

#  hardware.opengl = {
#    enable = true;
#    extraPackages = with pkgs; [
#      intel-media-driver
#      vaapiIntel
#      libvdpau-va-gl
#    ];
#  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-b9265499-c809-4bab-92a0-dd22cecb508a".device = "/dev/disk/by-uuid/b9265499-c809-4bab-92a0-dd22cecb508a";
  boot.initrd.luks.devices."luks-b9265499-c809-4bab-92a0-dd22cecb508a".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "tinky"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mwood = {
    isNormalUser = true;
    description = "Mark Wood";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Power settings
  services.thermald.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
#      CPU_SCALING_GOVERNOR_ON_AC="performance";
#      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
#      CPU_ENERGY_PERF_POLICY_ON_AC="balance_performance";
#      CPU_ENERGY_PERF_POLICY_ON_BAT="power";
#      PCIE_ASPM_ON_AC="default";
#      PCIE_ASPM_ON_BAT="powersupersave";
#      SCHED_POWERSAVE_ON_AC=0;
#      SCHED_POWERSAVE_ON_BAT=1;
      START_CHARGE_THRESH_BAT1=75;
      STOP_CHARGE_THRESH_BAT1=85;
      START_CHARGE_THRESH_BAT2=75;
      STOP_CHARGE_THRESH_BAT2=85;
#      RUNTIME_PM_ON_AC="on";
#      RUNTIME_PM_ON_BAT="auto";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
