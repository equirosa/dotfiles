{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ pulsemixer ];
  hardware.pulseaudio = { enable = true; };
}
