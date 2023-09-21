{ pkgs, ... }: {
  imports = [ ./firefox.nix ./qutebrowser ];
  home.packages = with pkgs; [
    mullvad-browser
    tor-browser-bundle-bin
  ];
}
