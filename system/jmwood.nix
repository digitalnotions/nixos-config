#
# User configuration that is NOT home manager controlled
#

{ lib, pkgs, inputs, ... }:

let
  user = "jmwood";
in
{  
  users.users.${user} = {
    isNormalUser = true;
    description = "Jackson Wood";
    hashedPassword = "$6$hO5IwPWnj0Jn8gTq$NMur8wX4i/IpXZ086AojJpn6ThfIaTCcb0KaqEkThhsC3fyh90HnNasoeC5KDQNZuDZYzZjHjSUJMJRTltTV11";
    home = "/home/${user}";
    extraGroups = [ "networkmanager" ];
    shell = pkgs.zsh;
  };

}
