{ config, pkgs, ... }: {
  imports = [ ./xserver.nix ];
  services.xserver.windowManager.awesome.enable = true;
  programs.slock.enable = true;
}
