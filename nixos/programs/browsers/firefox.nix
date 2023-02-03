{ pkgs, config, ... }:
let
  globalSettings = { };
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      cfg = { enableTridactylNative = true; };
    };
    enableGnomeExtensions = false;
  };
  programs.librewolf = {
    enable = true;
    settings = { };
  };
}
