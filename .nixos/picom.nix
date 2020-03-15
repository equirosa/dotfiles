{ config, pkgs, ... }: {
  services.picom = {
    enable = true;
    fade = true;
    inactiveOpacity = "0.8";
  };
}
