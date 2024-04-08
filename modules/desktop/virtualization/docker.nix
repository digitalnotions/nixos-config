{ config, pkgs, user, ... }:

{
  users.extraGroups.docker.members = [ "${user}" ];

  virtualisation = {
    docker.enable = true;
  };
}
