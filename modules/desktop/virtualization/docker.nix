{ config, pkgs, user, ... }:

{
  users.extraGroups.docker.members = [ "${user}" ];
  users.extraGroups.cdrom.members = [ "${user}" ];

  virtualisation = {
    docker.enable = true;
  };
}
