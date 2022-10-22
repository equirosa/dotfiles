{ config
, pkgs
, ...
}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.dnsname.enable = true;
  };
  home-manager.users.kiri = {
    home.packages = builtins.attrValues { inherit (pkgs) distrobox; };
  };
}
