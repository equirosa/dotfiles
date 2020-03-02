{ config, pkgs, ... }: {
  imports = [
    <home-manager/nixos>
    ./firefox.nix
    ./git.nix
    ./tor.nix
    ./user.nix
    ./vim.nix
    ./zsh.nix
  ];
  environment = {
    shellAliases = {
      aerc = "torify aerc";
      c = "cd";
      g = "git";
      grep = "grep --colour=auto";
      ls = "ls --color=auto --group-directories-first";
      lg = "lazygit";
      diff = "diff --color=auto";
    };
    systemPackages = with pkgs; [
      aerc # Mail reader
      calc # Calculator
      croc # File transfer
      ed # THE STANDARD TEXT EDITOR
      lf # terminal file manager
      gopass # password manager frontend
      kitty # terminal emulator
      # nixfmt
      qutebrowser # favourite browser
      trash-cli # handle trashing files instead of deleting them
      lazygit # git helper
      speedtest-cli
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
