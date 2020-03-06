{ config, pkgs, ... }: {
  imports = [ ./plasma.nix ];
  users.users.ricardo = {
    isNormalUser = true;
    packages = with pkgs; [
      firefox
      vscodium
    ];
    initialPassword = "ricardo";
  };
}
