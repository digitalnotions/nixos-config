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
    description = "Jackson Wigglebutt";
    hashedPassword = "$6$A2U1zNgojcB/PXaZ$jgcP6J2s6dFwX8coFw2dKk3DOaKFKurdamzt4dVXjfOwIlZ0W.PKJXFbr0hnhblx.zG8wcFdtxNLzFejnROw/1";
    home = "/home/${user}";
    extraGroups = [ "networkmanager" ];
    shell = pkgs.zsh;
  };

}
