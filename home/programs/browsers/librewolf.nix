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
      };
    };
  };
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-wayland;
    inherit settings;
  };
}
