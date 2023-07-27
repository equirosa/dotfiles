{ pkgs
, inputs
, ...
}: {
  imports = [
    ./browsers/librewolf.nix
    ./browsers/qutebrowser.nix
    ./editors/neovim
    ./editors/emacs
    ./git.nix
    ./lf.nix
    ./mpv.nix
    ./newsboat.nix
    ./rofi.nix
    ./scripts
    ./terminal
    ./zellij.nix
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
    mullvad-browser
    tor-browser-bundle-bin
    # Messengers
    aerc
    # Social
    toot
    # Documents
    standardnotes
    texlive.combined.scheme-full
    # File Sharing
    transmission
    tremc
    # Nix-specific stuff
    cachix
    deadnix
    nix-update
    nixpkgs-review
    statix
    # Utilities
    archiver
    compsize
    cryfs
    du-dust
    fd
    git-ignore
    gocryptfs
    hut
    hyprpicker
    imv
    inputs.hypr-contrib.packages.${system}.grimblast
    libnotify
    mediainfo
    parallel-full
    qpwgraph
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
