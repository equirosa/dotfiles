{ pkgs, ... }: {
  imports = [
    ./default.nix
    ./browsers
    ./editors/emacs
    ./rofi.nix
    ./scripts/linux.nix
  ];
  programs.rbw = {
    enable = true;
    settings = {
      email = "bitwarden@eduardoquiros.com";
      pinentry = "gnome3";
    };
  };
  home.packages = with pkgs; [
    # Messengers
    aerc
    betterbird
    thunderbird
    # Password
    bitwarden
    # Messengers
    # Social
    toot
    # Development
    mprocs
    # Documents
    libreoffice
    texlive.combined.scheme-full
    # File Sharing
    transmission
    tremc
    # Nix-specific stuff
    deadnix
    nix-output-monitor
    nix-update
    nixd
    nixpkgs-fmt
    nixpkgs-review
    statix
    # Utilities
    du-dust
    fd
    git-ignore
    gocryptfs
    handbrake
    hut
    hyperfine
    hyprpicker
    libnotify
    mediainfo
    parallel-full
    qpwgraph
    ripgrep
    swww
    trashy
    wl-clipboard
    # Compression
    archiver
    compsize
    lzip
    p7zip
    tarlz
    unzip
  ];
}
