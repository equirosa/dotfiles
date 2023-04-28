{ pkgs
, lib
, ...
}:
let
  inherit (import ../util.nix { inherit pkgs lib; }) nixFilesIn;
in
{
  imports = [
    ./flatpak.nix
    ./editors/emacs.nix
  ];
  nixpkgs.overlays = [
    (import (fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];
  home-manager.users.kiri = { config, ... }: {
    imports = [
      ./browsers/firefox.nix
      ./git.nix
      ./lf.nix
      ./terminal
      ./mpv.nix
      ./newsboat
      ./rofi.nix
      ./scripts.nix
      ./thunderbird.nix
      ./editors/neovim.nix
    ];
    programs.rbw = {
      enable = true;
      settings = { email = "bitwarden@eduardoquiros.com"; pinentry = "gnome3"; };
    };
    home.packages = with pkgs;
      [
        # Browsers
        tor-browser-bundle-bin
        # Messengers
        aerc
        catimg
        element-desktop-wayland
        signal-desktop
        # Documents
        onlyoffice-bin
        hunspell
        hunspellDicts.en-us-large
        hunspellDicts.es-any
        pandoc
        tectonic
        # File Sharing
        transmission
        tremc
        # Nix-specific stuff
        cachix
        comma
        nil
        nix-update
        nixpkgs-review
        statix
        # Utilities
        archiver
        cryfs
        du-dust
        fd
        imv
        libnotify
        qpwgraph
        qrencode
        ripgrep
        trash-cli
        # Password
        bitwarden
        gopass
      ];
  };
}
