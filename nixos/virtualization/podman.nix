{ config
, pkgs
, ...
}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  home-manager.users.kiri = {
    home.packages = builtins.attrValues { inherit (pkgs) distrobox; };
  };
}
