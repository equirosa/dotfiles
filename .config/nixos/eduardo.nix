{ config, lib, pkgs, ... }: {
  imports = [
    <home-manager/nixos>
    ./misc/32bit.nix
    ./editors/neovim.nix
    ./window-managers/xorg/awesome.nix
    ./emacs.nix
    ./location.nix
    ./theme.nix
    ./printing.nix
    ./tor.nix
    ./audio.nix
    ./flatpak.nix
    ./fonts.nix
    ./browsers/firefox.nix
    ./kdeConnect.nix
    ./terminals/kitty.nix
  ];
  users.users.eduardo = {
    createHome = true;
    description = "Eduardo Quiros";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    home = "/home/eduardo";
    initialHashedPassword =
      "$6$IpW9o6X.83H$mYxouAAprMhh83PVbRrwRDk684.u9vfPjwXWBrpYEveIEirvlIh.IUXaoKFknetTGTq9xnKfM/bi.5pYaXLUU/";
    isNormalUser = true;
    packages = with pkgs; [
      #### Backups ####
      restic

      #### Browsers ####
      brave
      next # The other best browser ever
      qutebrowser # Best browser ever
      tor-browser-bundle-bin # Tor Browser

      #### Comms ####
      aerc # Mail reader
      dino # XMPP client
      qtox # Decentralized messaging platform
      riot-desktop # Matrix client
      signal-desktop # Signal
      tdesktop # Telegram

      #### Dev Stuff ####
      gitAndTools.gitFull

      #### FAH Stuff :) ####
      fahviewer
      fahcontrol

      #### File Management ####
      atool # Makes handling compression easier
      exa # 'ls' replacement
      lf # Terminal file manager
      glow # Prettify markdown
      highlight # Prettify the rest
      mediainfo # prints info of media binary files
      p7zip
      zip
      unzip
      lzip

      #### File Transfer ####
      croc # Sync file transfer
      ffsend# Async file transfer

      #### TODO: Sort these... ####
      udiskie
      bat
      htop
      gotop
      calc # calculator
      fd # replacement for 'find'
      imv # Image viewer
      drive # stuff that i use to make Google drive less unbearable
      gnome3.gnome-disk-utility
      gopass # Password Manager
      ispell # spellchecking
      keychain # Fewer password prmpts
      lazygit # git for lazy people
      libnotify # Notification stuff
      lf # Terminal file manager
      mpv # Video Player
      perl530Packages.FileMimeInfo # mimetype stuff
      poppler_utils # reading PDFs
      ripgrep # grep but faster
      spaceFM # Graphical file manager
      speedtest-cli
      starship #pretty prompt
      toot # Mastodon client
      transmission
      transmission-remote-cli
      trash-cli # Trash files
      youtube-dl
      zathura # Doc viewer

      #### Nixpkgs stuff
      nix-prefetch-git
      nix-prefetch-github
      nixfmt
      nox
      vgo2nix

      #### Org mode things ####
      texlive.combined.scheme-full # LaTeX stuff

      #### Rust Dev ####
      cargo

      #### Cenfotec ####
      cmake
      gcc
      zoom-us
      slack
      qtcreator
      gnumake
      jetbrains.clion

      #### Java Sadness ####
      eclipses.eclipse-java
      jetbrains.idea-community

      #### Gaming ####
      steam
      lutris
    ];
  };
  nix.autoOptimiseStore = true;
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: super: {
        vim = super.vim.override {
          plugins = with pkgs.vimPlugins; [
            vim-nix
          ];
        };
      })
    ];
  };
  programs = {
    dconf.enable = true;
    firejail = {
      enable = true;
      wrappedBinaries = {
        zoom-us = "${lib.getBin pkgs.zoom-us}/bin/zoom-us";
      };
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    spacefm.enable = true;
    thefuck.enable = true;
    udevil.enable = true;
  };
  services = {
    stubby.enable = true;
    foldingathome.enable = true;
  };
  system.autoUpgrade = {
    enable = true;
    dates = "0/4:*:*";
  };
  time.timeZone = "America/Costa_Rica";
}
