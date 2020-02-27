{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ pavucontrol ];
  hardware.pulseaudio = {
    enable = true;
    # support32Bit = true;
  };
}
