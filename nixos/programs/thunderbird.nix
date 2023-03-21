{ config, pkgs, ... }: {
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird;
    profiles = {
      main = {
        isDefault = true;
        withExternalGnupg = true;
        settings = {
          "general.useragent.override" = "";
          "privacy.donottrackheader.enabled" = true;
        };
      };
    };
  };
}
