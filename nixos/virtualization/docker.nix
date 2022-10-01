{ config
, pkgs
, ...
}: {
  virtualisation.docker.enable = true;
  users.users.kiri.extraGroups = [ "docker" ];
}
