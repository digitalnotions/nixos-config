#
# Video playback and encoding tools
#

{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      makemkv
      handbrake
      vlc
    ];
  };
}
