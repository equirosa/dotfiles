{ pkgs, ... }:
let
  inherit (pkgs.nur.repos.rycee) firefox-addons;
  defaultSearch = "DuckDuckGo";
  settings = {
    "extensions.pocket.enabled" = false;
    "identity.fxaccounts.enabled" = true;
    "image.jxl.enabled" = true;
    "privacy.resistFingerprinting.letterboxing" = true;
    "browser.safebrowsing.downloads.remote.enabled" = false;
    "signon.autofillForms" = false;
    "signon.formlessCapture.enabled" = false;
    "browser.startup.page" = 0;
    "browser.startup.homepage" = "about:blank";
    "browser.newtabpage.enabled" = false;
  };
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
    profiles = {
      default = {
        id = 0;
        inherit settings;
        search = {
          default = defaultSearch;
          force = true;
        };
        extensions = with firefox-addons; [
          bitwarden
          libredirect
          multi-account-containers
        ];
      };
      media = {
        id = 1;
        settings = settings // {
          "browser.startup.homepage" = "https://reader.miniflux.app";
        };
        search = { default = defaultSearch; force = true; };
        extensions = with firefox-addons; [
          libredirect
        ];
      };
    };
  };
}
