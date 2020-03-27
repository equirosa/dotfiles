{ config, pkgs, ... }: {
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
    ./terminals/alacritty.nix
  ];
  environment = {
    homeBinInPath = true;
    shellAliases = {
      aerc = "torify aerc";
      c = "cd";
      cat = "bat -p";
      fd = "fd -I";
      find = "fd";
      g = "torify git";
      grep = "grep --colour=auto";
      regrep = "grep -d recurse";
      ls = "ls --color=auto --group-directories-first";
      lg = "lazygit";
      dateh = "date --help | grep %";
      diff = "diff --color=auto";
      #### Nix Aliases ####
      rebuild = "sudo nixos-rebuild switch";
      nsearch = "nix-env -qaP --description";
    };
    variables = {
      BROWSER = "qutebrowser";
      IDEA_PROPERTIES = "$HOME/.config/intellij-idea/idea.properties";
      IDEA_VM_OPTIONS = "$HOME/.config/intellij-idea/idea.vmoptions";
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
  home-manager.users.eduardo = { pkgs, ... }: {
    home = { packages = with pkgs; [ gopass ]; };
    programs = {
      bat = {
        enable = true;
        config = {
          pager = "less -FR";
          theme = "Monokai Extended";
        };
      };
      keychain = {
        enable = true;
        agents = [ "ssh" "gpg" ];
        enableBashIntegration = true;
        enableXsessionIntegration = true;
        inheritType = "local-once";
        keys = [ "sourcehut" "github" "gitlab" "codeberg" "B77F36C3F12720B4" ];
      };
      mpv = {
        enable = true;
        config = {
          force-window = "yes";
          ytdl-format = "bestvideo+bestaudio";
        };
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
      calc # calculator
      croc
      magic-wormhole
      fd # replacement for 'find'
      ffsend # Transfer stuff
      drive # stuff that i use to make Google drive less unbearable
      gnome3.gnome-disk-utility
      ispell # spellchecking
      lazygit # git for lazy people
      libnotify # Notifiation stuff
      lf # Terminal file manager
      perl530Packages.FileMimeInfo # mimetype stuff
      poppler_utils # reading PDFs
      qutebrowser # Best browser ever
      spaceFM # Graphical file manager
      speedtest-cli
      toot # Mastodon client
      tor-browser-bundle-bin # Tor Browser
      transmission
      transmission-remote-cli
      trash-cli # Trash files
      youtube-dl
      zathura # Doc viewer

      #### Org mode things ####
      texlive.combined.scheme-full # LaTeX stuff

      #### Messaging ####
      aerc # Mail reader
      tdesktop # Telegram
      signal-desktop # Signal

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
      gcc
      zoom-us
      slack

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
    gnupg.agent = { enable = true; enableSSHSupport = true; };
    spacefm.enable = true;
    thefuck.enable = true;
    udevil.enable = true;
  };
  system.autoUpgrade = {
    enable = true;
    dates = "0/4:*:*";
  };
  time.timeZone = "America/Costa_Rica";
}
