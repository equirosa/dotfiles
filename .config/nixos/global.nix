{ config, lib, pkgs, ... }: {
  imports = [
    <home-manager/nixos>
    ./window-managers/xorg/awesome.nix
    ./backups/external.nix
    ./misc/32bit.nix
    ./misc/cleanup.nix
    ./packages/insecure.nix
    ./packages/unfree.nix
    ./location.nix
    ./printing.nix
    ./tor.nix
    ./audio.nix
    ./security.nix
    ./flatpak.nix
    ./fonts.nix
    ./virtualization.nix
    ./theme.nix
  ];
  boot = { kernelPackages = pkgs.linuxPackages_latest; };
  environment = {
    # memoryAllocator.provider = "graphene-hardened";
    variables = {
      # Java
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";

      # 'Less' stuff
      LESS = "-R";
      LESS_TERMCAP_mb = "$(printf '%b' '[1;31m')";
      LESS_TERMCAP_md = "$(printf '%b' '[1;36m')";
      LESS_TERMCAP_me = "$(printf '%b' '[0m')";
      LESS_TERMCAP_so = "$(printf '%b' '[01;44;33m')";
      LESS_TERMCAP_se = "$(printf '%b' '[0m')";
      LESS_TERMCAP_us = "$(printf '%b' '[1;32m')";
      LESS_TERMCAP_ue = "$(printf '%b' '[0m')";
    };
  };
  hardware.cpu.amd.updateMicrocode = true;
  users.users.eduardo = {
    shell = pkgs.fish;
    createHome = true;
    description = "Eduardo Quiros";
    extraGroups = [ "wheel" "video" "audio" ];
    initialHashedPassword =
      "$6$IpW9o6X.83H$mYxouAAprMhh83PVbRrwRDk684.u9vfPjwXWBrpYEveIEirvlIh.IUXaoKFknetTGTq9xnKfM/bi.5pYaXLUU/";
    isNormalUser = true;
    packages = with pkgs; [
      #### Backups & Sync ####
      restic
      syncthing
      qsyncthingtray

      #### Browsers ####
      firefox
      lynx # Lightweight cli web browser
      qutebrowser # Best browser ever
      tor-browser-bundle-bin # Tor Browser

      #### Comms ####
      aerc # Mail reader
      dino # XMPP client
      riot-desktop # Matrix client
      weechat # IRC + other protocols
      toot # Mastodon client
      tut # Mastodon client

      #### Dev Stuff ####
      gitMinimal

      #### File Management ####
      trash-cli # Trash files
      dragon-drop # Drag and drop so I don't use another FM to drag and drop.
      atool # Makes handling compression easier
      lf # Terminal file manager
      file # used to get file type
      glow # Prettify markdown
      highlight # Prettify the rest
      zip
      unzip
      zathura # PDF Reader

      #### File Transfer ####
      croc # Sync file transfer
      ffsend # Async file transfer

      #### Gaming ####
      chiaki # PS4 Remote Play utility
      lutris # General games client
      steam #

      #### TODO: Sort these... ####
      racket
      calc # calculator
      fd # replacement for 'find'
      imv # Image viewer
      drive # stuff that i use to make Google drive less unbearable
      gopass # Password Manager
      keychain # Fewer password prmpts
      lazygit # git for lazy people
      libnotify # Notification stuff
      speedtest-cli
      transmission # Torrent client
      stig # Transmission frontend TUI

      #### Nixpkgs stuff
      nix-prefetch-git
      nix-prefetch-github
      nox # YAY but for nixpkgs intead of AUR
      rnix-lsp

      #### Org mode things ####
      texlive.combined.scheme-full # LaTeX stuff

      # Media Playback
      mpv # Video Player
      python3 # Necessary for umpv script to work
      streamlink # Streaming utility
      youtube-dl # Video downloading utility

      #### Document ####
      ispell # spellchecking
      neovim # EDITOR
      fzf # fuzzy finder
      nodejs # For Coc.nvim
      pandoc # Doc processing

      #### Utilities ####
      udiskie
      bat
      kitty # Terminal Emulator
      st
      starship # Prompt
      gotop # Cooler process viewer
    ];
  };
  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };
  nixpkgs = {
    overlays = [
      (
        self: super: {
          gopass = super.gopass.override {
            passAlias = true;
          };
        }
      )
    ];
  };
  programs = {
    dconf.enable = true;
    firejail = {
      enable = true;
      wrappedBinaries = {
        anydesk = "${lib.getBin pkgs.anydesk}/bin/anydesk";
      };
    };
    fish = { enable = true; };
    gnome-disks.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thefuck.enable = true;
  };
  services = {
    udisks2.enable = true;
    stubby.enable = true;
  };
  system.autoUpgrade = {
    enable = true;
    dates = "12:00";
  };
  time.timeZone = "America/Costa_Rica";
}
