{ config, pkgs, ... }: {
  imports = [
    ./awesome.nix
    ./emacs.nix
    ./firefox.nix
    ./kdeConnect.nix
    ./kitty.nix
    #./plasma.nix
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
      croc magic-wormhole # Transfer stuff
      drive # stuff that i use to make Google drive less unbearable
      lf # Terminal file manager
      poppler_utils # reading PDFs
      ripgrep # grep replacement
      spaceFM # Graphical file manager
      texlive.combined.scheme-full # LaTeX stuff
      toot # Mastodon client
      zathura # Doc viewer

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
  };
}
