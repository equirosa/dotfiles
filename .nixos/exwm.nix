{ config, pkgs, ... }: {
  imports = [ ./xserver.nix ];
  services.xserver.windowManager.exwm = {
    enable = true;
    enableDefaultConfig = true;
    extraPackages = epkgs: [
      epkgs.emms
      epkgs.magit
      epkgs.nix-mode
      epkgs.markdown-mode
      epkgs.evil-mode
    ];
  };
}
