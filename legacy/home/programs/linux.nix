{ pkgs, ... }: {
  imports = [
    ./default.nix
    ./browsers
    ./editors/emacs
    ./rofi.nix
    ./scripts/linux.nix
    ./thunderbird.nix
  ];
  programs.rbw = {
    enable = true;
    settings = {
      email = "bitwarden@eduardoquiros.com";
      pinentry = "gnome3";
    };
  };
  xdg.desktopEntries = {
    firefox-media = {
      name = "Firefox Media Profile";
      icon = "firefox";
      genericName = "Web Browser";
      exec = "firefox -P media %U";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" ];
    };
    mirror-phone = {
      name = "Screen Copy";
      icon = "mirror";
      genericName = "Connect Phone";
      exec = "mirror-phone";
      terminal = false;
      categories = [ "Network" ];

    };
  };
  home.packages = with pkgs; [
    # Messengers
    aerc
    beeper
    thunderbird
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
    nix-output-monitor
    nix-update
    nixd
    nixpkgs-review
    # Utilities
    du-dust
    fd
    git-ignore
    gocryptfs
    handbrake
    hut
    hyperfine
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
    p7zip
  ];
}
