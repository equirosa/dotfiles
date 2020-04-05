{ config, lib, pkgs, ... }: {
  imports = [
    <home-manager/nixos>
    ./misc/32bit.nix
    ./editors/neovim.nix
    ./shell/bash.nix
    ./window-managers/xorg/awesome.nix
    ./emacs.nix
    ./lf.nix
    ./git.nix
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
  environment.homeBinInPath = true;
  home-manager.users.eduardo = { pkgs, ... }: {
    programs = {
      keychain = {
        enable = true;
        agents = [ "ssh" ];
        enableBashIntegration = true;
        inheritType = "local-once";
        keys = [ "sourcehut" "github" "gitlab" "codeberg" ];
      };
      starship = {
        enable = true;
        enableBashIntegration = true;
      };
    };
    services = {
      udiskie = {
        enable = true;
        automount = true;
        notify = true;
        tray = "auto";
      };
    };
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps.enable = true;
      userDirs.enable = true;
    };
  };
  users.users.eduardo = {
    createHome = true;
    description = "Eduardo Quiros";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    home = "/home/eduardo";
    initialHashedPassword =
      "$6$IpW9o6X.83H$mYxouAAprMhh83PVbRrwRDk684.u9vfPjwXWBrpYEveIEirvlIh.IUXaoKFknetTGTq9xnKfM/bi.5pYaXLUU/";
    isNormalUser = true;
    packages = with pkgs; [
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

      #### FAH Stuff :) ####
      fahviewer
      fahcontrol

      #### File Transfer ####
      croc # Sync file transfer
      ffsend# Async file transfer

      #### TODO: Sort these... ####
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
      lazygit # git for lazy people
      libnotify # Notification stuff
      lf # Terminal file manager
      mpv # Video Player
      perl530Packages.FileMimeInfo # mimetype stuff
      poppler_utils # reading PDFs
      ripgrep # grep but faster
      spaceFM # Graphical file manager
      speedtest-cli
      toot # Mastodon client
      transmission
      transmission-remote-cli
      trash-cli # Trash files
      youtube-dl
      zathura # Doc viewer

      #### Org mode things ####
      texlive.combined.scheme-full # LaTeX stuff

      #### Nixpkgs stuff
      nix-prefetch-git
      nix-prefetch-github
      nixfmt
      nox

      #### Rust Dev ####
      cargo

      #### Compression ####
      zip
      unzip

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
  nixpkgs.config.allowUnfree = true;
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
    foldingathome.enable = true;
  };
  system.autoUpgrade = {
    enable = true;
    dates = "0/4:*:*";
  };
  time.timeZone = "America/Costa_Rica";
}
