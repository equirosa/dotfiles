{ config, pkgs, ... }: {
  imports = [
    ./emacs.nix
    ./firefox.nix
    ./kdeConnect.nix
    ./kitty.nix
    ./sway.nix
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
      drive # stuff that i use to make Google drive less unbearable
      lf # Terminal file manager
      spaceFM # Graphical file manager
      texlive.combined.scheme-full # LaTeX stuff
      zathura # Doc viewer
      croc magic-wormhole # Transfer stuff

      #### Nixpkgs stuff
      nix-prefetch-git
      nix-prefetch-github

      #### Rust Dev ####
      cargo

      #### Compression ####
      zip unzip

      #### Java Sadness ####
      eclipses.eclipse-java
    ];
  };
}
