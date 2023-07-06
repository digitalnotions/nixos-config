{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neofetch
    cachix
    powertop
    unzip
    gzip
    ispell
    # Need ffmpeg-full for decoding H.264 in Firefox
    #ffmpeg_6-full
    killall
    wget
    rsync
    nvd # Allows diff of different NixOS generations
    #emacs-pgtk
  ];

  services.emacs = {
    enable = true;
    package = pkgs.emacs-git;
  };

}
