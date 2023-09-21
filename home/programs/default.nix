{ pkgs
, ...
}: {
  imports = [
    ./browsers
    ./editors/emacs
    ./editors/neovim
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
    # Messengers
    aerc
    betterbird
    # Social
    toot
    # Development
    mprocs
    # Documents
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
    trash-cli
    wl-clipboard
    # Compression
    archiver
    compsize
    lzip
    p7zip
    tarlz
    unzip
    # Password
    bitwarden
  ];
}
