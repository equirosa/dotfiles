{pkgs, ...}: {
  imports = [
    ./browsers/firefox.nix
    ./git.nix
    ./lf.nix
    ./terminal
    ./mpv.nix
    ./rofi.nix
    ./scripts
    ./editors/neovim
  ];
  programs.rbw = {
    enable = true;
    settings = {
      email = "bitwarden@eduardoquiros.com";
      pinentry = "gnome3";
    };
  };
  home.packages = with pkgs; [
    # Browsers
    tor-browser-bundle-bin
    # Messengers
    aerc
    element-desktop-wayland
    # Social
    toot
    # Documents
    onlyoffice-bin
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.es-any
    # File Sharing
    transmission
    tremc
    # Nix-specific stuff
    cachix
    deadnix
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
    parallel-full
    qpwgraph
    qrencode
    ripgrep
    trash-cli
    wl-clipboard
    # Password
    bitwarden
    gopass
  ];
}