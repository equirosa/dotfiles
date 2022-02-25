{ pkgs, gtk3, ... }:
let
  commonSettings = {
    "browser.contentblocking.category" = "strict";
    "extensions.pocket.enabled" = false;
  };
in
{
  home-manager.users.kiri = {
    programs = {
      firefox = {
        enable = true;
        /* extensions = with pkgs.nur; with repos.rycee.firefox-addons; [
          gopass-bridge
          privacy-redirect
          tridactyl
          ublock-origin
          repos.pborzenkov.firefox-addons.wallabagger
          ]; */
        profiles = {
          default = {
            settings = commonSettings;
          };
        };
      };
    };
  };
}
