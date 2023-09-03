{ pkgs
, ...
}: {
  imports = [
    ./browsers/librewolf.nix
    ./browsers/qutebrowser.nix
    ./editors/neovim
    ./editors/emacs
    ./editors/vscode.nix
    ./git.nix
    ./lf.nix
    ./mpv.nix
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
    betterbird
    # Social
    toot
    # Documents
    joplin-desktop
    standardnotes
    texlive.combined.scheme-full
    # File Sharing
    transmission
    tremc
    # Nix-specific stuff
    cachix
    deadnix
    nix-output-monitor
    nix-update
    nixd
    nixpkgs-review
    statix
    # Utilities
    du-dust
    fd
    git-ignore
    gocryptfs
    hut
    hyperfine
    hyprpicker
    libnotify
    mediainfo
    parallel-full
    qpwgraph
    ripgrep
    swww
    trash-cli
    wl-clipboard
    # Compression
    archiver
    compsize
    lzip
    tarlz
    unzip
    # Password
    bitwarden
    gopass
  ];
}
