{
  pkgs,
  inputs,
  ...
}: {
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
    ferdium
    element-desktop-wayland
    # Social
    toot
    # Documents
    onlyoffice-bin
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.es-any
    texlive.combined.scheme-full
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
    hyprpicker
    imv
    inputs.hypr-contrib.packages."x86_64-linux".grimblast
    libnotify
    parallel-full
    qpwgraph
    qrencode
    ripgrep
    swww
    trash-cli
    unzip
    wl-clipboard
    # Password
    bitwarden
    gopass
  ];
}
