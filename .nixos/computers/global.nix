{ config, pkgs, ... }: {
  imports = [
    <home-manager/nixos>
    ../audio.nix
    ../bat.nix
    ../flatpak.nix
    ../fonts.nix
    ../git.nix
    ../location.nix
    ../kitty.nix
    ../lf.nix
    ../mpv.nix
    ../neovim.nix
    ../nix.nix
    ../pass.nix
    ../printing.nix
    ../theme.nix
    ../tor.nix
    ../zsh.nix
    #### User Stuff ####
    ../eduardo.nix
    ../ricardo.nix
  ];
  environment = {
    homeBinInPath = true;
    shellAliases = {
      aerc = "torify aerc";
      c = "cd";
      g = "git";
      grep = "grep --colour=auto";
      regrep = "grep -d recurse";
      ls = "ls --color=auto --group-directories-first";
      lg = "lazygit";
      diff = "diff --color=auto";
      #### Nix Stuff ####
      rebuild = "sudo nixos-rebuild switch";
      upgrade = "sudo nixos-rebuild switch --upgrade";
      nsearch = "nix-env -qaP --description";
    };
    systemPackages = with pkgs; [
      calc # Calculator
      croc magic-wormhole # File transfer
      gopass # password manager frontend
      groff # Document formatting
      htop # monitor
      kitty # terminal emulator
      # nixfmt
      qutebrowser # favourite browser
      trash-cli # handle trashing files instead of deleting them
      lazygit # git helper
      neofetch # UnixPorn
      nox # Yay but for Nix
      speedtest-cli
      starship # pretty prompt :P
      syncthing
      qsyncthingtray
      transmission
      transmission-remote-cli
      youtube-dl # YouTube downloader
      tor-browser-bundle-bin # Tor Browser (obviously)

      #### Global Java Sadness ####
      eclipses.eclipse-java
      jetbrains.idea-community
    ];
    variables = {
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
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  time.timeZone = "America/Costa_Rica";
}
