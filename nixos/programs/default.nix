{ pkgs
, lib
, ...
}:
let
  filesIn = { dir, ext }: lib.attrsets.mapAttrsToList (name: _: "${dir}/${name}")
    (lib.attrsets.filterAttrs (name: _: lib.strings.hasSuffix ".${ext}" name)
      (builtins.readDir dir));
  nixFiles = dir: filesIn { inherit dir; ext = "nix"; };
in
{
  imports = [
    ./flatpak.nix
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
      ./terminal/foot.nix
      ./mpv.nix
      ./newsboat
      ./rofi.nix
      ./scripts.nix
      ./thunderbird.nix
    ] ++ nixFiles ./editors;
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
        nix-update
        nixpkgs-review
        rnix-lsp
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
