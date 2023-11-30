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
  xdg.desktopEntries = {
    beeper = {
      name = "Beeper";
      icon = "beeper";
      genericName = "Messenger";
      exec = "beeper";
      terminal = false;
      categories = [ "Application" "Network" "Messengers" ];
    };
    firefox-media = {
      name = "Firefox Media Profile";
      icon = "firefox";
      genericName = "Web Browser";
      exec = "firefox -P media %U";
      terminal = false;
      categories = [ "Application" "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" ];
    };
    mirror-phone = {
      name = "Screen Copy";
      icon = "mirror";
      genericName = "Connect Phone";
      exec = "mirror-phone";
      terminal = false;
      categories = [ "Application" ];

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
