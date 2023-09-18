{ pkgs, ... }:
let
  settings = {
    "extensions.pocket.enabled" = false;
    "identity.fxaccounts.enabled" = true;
    "image.jxl.enabled" = true;
    "privacy.resistFingerprinting.letterboxing" = true;
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
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          libredirect
        ];
      };
      media = {
        id = 1;
        settings = settings // {
          "browser.startup.homepage" = "https://reader.miniflux.app";
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          libredirect
        ];
      };
    };
  };
}
