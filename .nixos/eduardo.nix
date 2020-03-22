{ config, pkgs, ... }: {
  imports = [
    ./home-manager/shell/bash.nix
    ./awesome.nix
    ./emacs.nix
    ./firefox.nix
    ./kdeConnect.nix
    ./home-manager/terminals/kitty.nix
    ./udiskie.nix
  ];
  programs = {
    spacefm = {
      enable = true;
    };
    udevil.enable = true;
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
      aerc # Mail reader
      croc magic-wormhole ffsend # Transfer stuff
      drive # stuff that i use to make Google drive less unbearable
      gnome3.gnome-disk-utility
      ispell # spellchecking
      libnotify # Notifiation stuff
      lf # Terminal file manager
      poppler_utils # reading PDFs
      ripgrep # grep replacement
      spaceFM # Graphical file manager
      toot # Mastodon client
      zathura # Doc viewer

      #### Org mode things ####
      texlive.combined.scheme-full # LaTeX stuff

      #### Messaging ####
      tdesktop

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
    ];
    shell = pkgs.bashInteractive_5;
  };
  nixpkgs.config.allowUnfree = true;
  programs = {
    dconf.enable = true;
  };
}
