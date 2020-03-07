{ config, pkgs, ... }: {
  imports = [ ./plasma.nix ];
  users.users.ricardo = {
  createHome = true;
    description = "Ricardo Quiros";
    isNormalUser = true;
    packages = with pkgs; [
      firefox
      vscodium
    ];
    initialHashedPassword = "$6$s1.3grZyK$W76s2Ho1DQBJpGjX9UJBoqZd9Ie6AIeYICCyc2N.RYq9BbK.kf8Rx1P6N8RMxWP3S98iwGB1uwNDq/0ZEphtW1";
  };
}
