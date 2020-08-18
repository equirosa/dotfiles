{ config, ... }: {
  security = {
    doas = {
      enable = true;
      extraConfig = "permit eduardo as root";
    };
    hideProcessInformation = true;
  };
}
