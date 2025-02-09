#
# User configuration that is NOT home manager controlled
#

{ lib, pkgs, inputs, ... }:

let
  user = "minecraft";
in
{  
  users.users.${user} = {
    isNormalUser = true;
    description = "Minecraft";
    hashedPassword = "$6$okZhXRRkZSz97g9u$W8QKtnZq1cp.Zu1x5pkgkDCTjOdPUOVB/A8VQZ15YMJ1hSjUgRnzOyTsucQT5tyop11Qn4is9KLBSDi95F7Oh.";
    home = "/home/${user}";
    extraGroups = [ "networkmanager" ];
    shell = pkgs.zsh;
  };

}
