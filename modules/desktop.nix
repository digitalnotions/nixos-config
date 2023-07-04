{ pkgs, lib, config, ... }:

with lib;
{
  nix = {
    package = pkgs.nixVersions.stable;
  };

#  nix.settings = {
#    substituters = ["https://hyprland.cachix.org"];
#    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
#  };

  fonts.fonts = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    dina-font
    proggyfonts
    fira-mono
  ];

#  programs.hyprland = {
#    enable = true;
#    xwayland.enable = true;
#    xwayland.hidpi = false;
#  };

  # Sort out virtualization
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Configure keymap in X11
#  services.xserver = {
#    layout = "us";
#    xkbVariant = "";
#  };

  # Enable Sound
#  services.pipewire = {
#    enable = true;
#    alsa.enable = true;
#    pulse.enable = true;
#    wireplumber.enable = true;
#  };

  # Enable disk mounting
#  services.udisks2.enable = true;

  environment.localBinInPath = true;

  environment.variables = {
    EDITOR = "emacsclient -t -a";
    VISUAL = "emacsclient -c -a";
#    GDK_BACKEND = "wayland";
#    MOZ_ENABLE_WAYLAND = "1";
#    XDG_SESSION_TYPE = "wayland";
#    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
#    QT_QPA_PLATFORM = "wayland";
#    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Configure Syncthing
  services.syncthing = {
    enable = true;
    dataDir = "/home/mwood/";
    user = "mwood";
    openDefaultPorts = true;
    configDir = "/home/mwood/.config/syncthing";
  };

  # Enable KDE Partition manager
  programs.partition-manager.enable = true;

}
