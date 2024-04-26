#
# User configuration that is NOT home manager controlled
#

{ lib, pkgs, inputs, ... }:

let
  user = "mwood";
in
{
  environment.variables = {
    EDITOR = "emacsclient -t";
    VISUAL = "emacsclient -c";
  };
  
  users.users.${user} = {
    isNormalUser = true;
    description = "Mark Wood";
    home = "/home/${user}";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.zsh;
  };

  services = {
    syncthing = {
      enable = true;
      dataDir = "/home/${user}/";
      user = "${user}";
      openDefaultPorts = true;
      configDir = "/home/${user}/.config/syncthing";
    };
  };
}
