{ config, pkgs, ... }: {
  imports = [
    ./home-manager/shell/bash.nix
    ./home-manager/window-managers/i3.nix
    ./awesome.nix
    ./emacs.nix
    ./firefox.nix
    ./kdeConnect.nix
    ./home-manager/terminals/kitty.nix
    ./udiskie.nix
  ];
  home-manager.users.eduardo = { pkgs, ... }: {

  };
  users.users.eduardo = {
    createHome = true;
    description = "Eduardo Quiros";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    home = "/home/eduardo";
    initialHashedPassword =
      "$6$n3GzxIULPTTidjy$8TABYAaFlEo/I49XGq1WpUCxpIZzrbxddlAXudwisO7S4y2Xi1e7ZQtUp1b/F8HiXLFi.WUBEie.a9/R/ewoJ0";
    isNormalUser = true;
    packages = with pkgs; [
      croc magic-wormhole ffsend # Transfer stuff
      drive # stuff that i use to make Google drive less unbearable
      gnome3.gnome-disk-utility
      ispell # spellchecking
      libnotify # Notifiation stuff
      lf # Terminal file manager
      perl530Packages.FileMimeInfo # mimetype stuff
      poppler_utils # reading PDFs
      spaceFM # Graphical file manager
      toot # Mastodon client
      zathura # Doc viewer

      #### Org mode things ####
      texlive.combined.scheme-full # LaTeX stuff

      #### Messaging ####
      aerc # Mail reader
      tdesktop # Telegram

      #### Nixpkgs stuff
      nix-prefetch-git
      nix-prefetch-github

      #### Rust Dev ####
      cargo

      #### Compression ####
      zip unzip

      #### Cenfotec ####
      gcc
      zoom-us
      slack

      #### Java Sadness ####
      eclipses.eclipse-java

      #### Gaming ####
      steam lutris
    ];
    shell = pkgs.bashInteractive_5;
  };
  nix.autoOptimiseStore = true;
  nixpkgs.config.allowUnfree = true;
  programs = {
    dconf.enable = true;
    thefuck.enable = true;
    spacefm.enable = true;
    udevil.enable = true;
  };
  system.autoUpgrade = {
    enable = true;
    dates = "0/4:*:*";
  };
}
