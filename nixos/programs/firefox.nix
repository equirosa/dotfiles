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
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          clearurls
          gopass-bridge
          privacy-redirect
          tridactyl
          ublock-origin
        ];
        profiles = {
          default = {
            settings = commonSettings;
          };
        };
      };
    };
  };
}
