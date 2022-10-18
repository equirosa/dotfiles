{ config, pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = builtins.attrValues { inherit (pkgs) hplip; };
  };
}
