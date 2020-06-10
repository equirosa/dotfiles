{ config, pkgs, ... }: {
  services.picom = {
    enable = true;
    fade = true;
    inactiveOpacity = 0.8;
    opacityRules = [ "100:class_g = 'i3lock'" ];
  };
}
