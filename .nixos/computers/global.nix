{ config, pkgs, ... }: {
  imports = [
    <home-manager/nixos>
    ../audio.nix
    ../firefox.nix
    ../fonts.nix
    ../git.nix
    ../location.nix
    ../kitty.nix
    ../lf.nix
    ../mpv.nix
    ../nix.nix
    ../pass.nix
    ../theme.nix
    ../tor.nix
    ../user.nix
    ../vim.nix
    ../zsh.nix
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
    };
    systemPackages = with pkgs; [
      aerc # Mail reader
      busybox # another coreutils
      calc # Calculator
      croc magic-wormhole # File transfer
      ed # THE STANDARD TEXT EDITOR
      lf # terminal file manager
      gopass # password manager frontend
      htop # monitor
      kitty # terminal emulator
      # nixfmt
      qutebrowser # favourite browser
      trash-cli # handle trashing files instead of deleting them
      lazygit # git helper
      speedtest-cli
      starship # pretty prompt :P
      transmission
      transmission-remote-cli
      youtube-dl # YouTube downloader
      tor-browser-bundle-bin # Tor Browser (obviously)
    ];
    variables = {
      BROWSER = "firefox";
      FILE = "lf";
      MAIL = "torify aerc";
      LESS = "-R";
      LESS_TERMCAP_mb = "$(printf '%b' '[1;31m')";
      LESS_TERMCAP_md = "$(printf '%b' '[1;36m')";
      LESS_TERMCAP_me = "$(printf '%b' '[0m')";
      LESS_TERMCAP_so = "$(printf '%b' '[01;44;33m')";
      LESS_TERMCAP_se = "$(printf '%b' '[0m')";
      LESS_TERMCAP_us = "$(printf '%b' '[1;32m')";
      LESS_TERMCAP_ue = "$(printf '%b' '[0m')";
      MONITOR = "htop";
      CALCULATOR = "calc";
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
