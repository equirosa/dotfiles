{ config, pkgs, ... }: {
    environment = {
      variables = {
        BROWSER = "firefox";
      };
    };
  home-manager.users.eduardo = { pkgs, ... }: {
    programs = {
      browserpass = {
        enable = true;
        browsers = [ "firefox" ];
      };
      firefox = {
        enable = true;
        package = pkgs.firefox;#-wayland;
        profiles = {
          default = {
            isDefault = true;
            name = "default";
            settings = {
              "browser.send_pings" = false;
              "extensions.pocket.enabled" = false;
              "extensions.screenshots.disabled" = true;
              "media.eme.enabled" = false;
              "media.navigator.enabled" = false;
              "network.cookie.cookieBehavior" = 1;
              "network.http.referer.XOriginPolicy" = 2;
              "network.http.XOriginTrimmingPolicy" = 2;
              "privacy.resistFingerprinting" = true;
            };
          };
        };
      };
    };
  };
}
