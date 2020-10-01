{ config, lib, pkgs, ... }: {
  imports = [
    <home-manager/nixos>
    ./window-managers/wayland/sway.nix
    ./editors/neovim.nix
    ./editors/emacs.nix
    ./shell.nix
    ./kdeConnect.nix
    ./backups/external.nix
    ./misc/32bit.nix
    ./misc/cleanup.nix
    ./packages/insecure.nix
    ./packages/unfree.nix
    ./location.nix
    ./printing.nix
    ./tor.nix
    ./audio.nix
    ./security.nix
    ./flatpak.nix
    ./fonts.nix
    ./virtualization.nix
    ./theme.nix
  ];
  boot = {
    #kernelPackages = pkgs.linuxPackages_latest; # Use latest available kernel
  };
  environment = {
    homeBinInPath = true;
    # memoryAllocator.provider = "graphene-hardened";
    loginShellInit = ''
      pgrep syncthing >/dev/null || syncthing & disown
      pgrep udiskie >/dev/null || udiskie & disown
      pgrep transmission-da >/dev/null || transmission-daemon & disown
      [ $(tty) = tty1 ] && exec sway
      [ $(tty) = tty2 ] && startx
    '';
    interactiveShellInit = ''
      [ -z "$TMUX" ] && [ -z $INSIDE_EMACS ] && exec tmux a
    '';
    shellAliases = {
      # General stuff
      nrebuild = "sudo nixos-rebuild switch --upgrade; flatpak update -y";
      # Emacs stuff
      elpa = "nix-env -f '<nixpkgs>' -qaP -A emacsPackages.melpaPackages";
      melpa = "nix-env -f '<nixpkgs>' -qaP -A emacsPackages.melpaPackages";
    };
    variables = {
      # Personal stuff
      MONITOR = "gotop";
      BROWSER = "qutebrowser";
      EDITOR = "nvim";
      FILE = "lf";
      IMG = "imv";
      MAIL = "torify aerc";
      TERMINAL = "alacritty";
      READER = "zathura";
      LF_ICONS =
        "di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.cpp=ﭱ:*.js=:*.vimrc=:*.vim=:*.nix=:*.css=:*.pdf=:*.html=:*.rs=:*.rlib=:*.7z=:*.zip=:*.xz=:*.tar=:*.lz=:*.git=:*.webm=:*.mp4=:*.flac=:*.ogg=:*.opus=:*.m4a=:*.deb=:*.rpm=:*.py=:*.md=:*.json=ﬥ :*.mkv=:*.go=:.git=:*.ts=ﯤ:*.xml=謹:*.drawio=謹";

      # Java
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";

      # 'Less' stuff
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
  hardware.cpu.amd.updateMicrocode = true;
  users.users.eduardo = {
    createHome = true;
    description = "Eduardo Quiros";
    extraGroups = [ "wheel" "video" "audio" ];
    initialHashedPassword =
      "$6$IpW9o6X.83H$mYxouAAprMhh83PVbRrwRDk684.u9vfPjwXWBrpYEveIEirvlIh.IUXaoKFknetTGTq9xnKfM/bi.5pYaXLUU/";
    isNormalUser = true;
    packages = with pkgs; [
      #### Backups & Sync ####
      restic
      syncthing
      qsyncthingtray

      #### Browsers ####
      ncgopher
      asuka
      firefox
      lynx # Lightweight cli web browser
      qutebrowser # Best browser ever
      tor-browser-bundle-bin # Tor Browser

      #### Comms ####
      aerc # Mail reader
      dino # XMPP client
      discord
      element-desktop # Matrix client
      gomuks
      signal-desktop
      weechat # IRC + other protocols
      toot # Mastodon client
      tut # Mastodon client

      #### Dev Stuff ####
      gitMinimal
      gibo # Generate ignore boilerplates
      licensor # LICENSE templater

      #### File Management ####
      trash-cli # Trash files
      dragon-drop # Drag and drop so I don't use another FM to drag and drop.
      atool # Makes handling compression easier
      lf # Terminal file manager
      file # used to get file type
      glow # Prettify markdown
      highlight # Prettify the rest
      zip
      unzip
      zathura # PDF Reader

      #### File Transfer ####
      croc # Sync file transfer
      ffsend # Async file transfer

      #### Gaming ####
      chiaki # PS4 Remote Play utility
      #lutris # General games client
      #steam # videogame store

      #### TODO: Sort these... ####
      imv # Image viewer
      drive # stuff that i use to make Google drive less unbearable
      gopass # Password Manager
      lazygit # git for lazy people
      libnotify # Notification stuff
      speedtest-cli
      transmission # Torrent client
      stig # Transmission frontend TUI

      #### Nixpkgs stuff
      nix-prefetch-git
      nix-prefetch-github
      nox # YAY but for nixpkgs intead of AUR
      rnix-lsp # language server for Nix
      nixfmt

      #### Org mode things ####
      texlive.combined.scheme-full # LaTeX stuff

      # Media Playback
      mpv # Video Player
      python3 # Necessary for umpv script to work
      streamlink # Streaming utility
      youtube-dl # Video downloading utility

      #### Document ####
      ispell # spellchecking
      nodejs # For Coc.nvim
      pandoc # Doc processing

      #### Utilities ####
      any-nix-shell # Allows using 'any' shell as a base for nix-shell
      calc # calculator
      gotop # Cooler process viewer
      alacritty # Terminal emulator
      starship # Prompt
      tealdeer # command examples
      udiskie

      #### Rust Replacements
      bat # Cat replacement
      exa # ls replacement
      fd # replacement for 'find'
      ripgrep # grep replacement
    ];
  };
  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };
  nixpkgs = {
    config = { pulseaudio = true; };
    overlays = [
      (
        import (
          builtins.fetchTarball {
            url =
              "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
          }
        )
      )
      (self: super: { gopass = super.gopass.override { passAlias = true; }; })
    ];
  };
  programs = {
    dconf.enable = true;
    firejail = {
      enable = true;
      wrappedBinaries = { anydesk = "${lib.getBin pkgs.anydesk}/bin/anydesk"; };
    };
    fish = { enable = true; };
    gnome-disks.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thefuck.enable = true;
    tmux = {
      enable = true;
      extraConfig = ''
        set -g default-command fish
        set -sg escape-time 10
        set -g focus-events on
        set -sa terminal-overrides ',xterm-256color:RGB'
      '';
      terminal = "screen-256color";
      newSession = true;
    };
  };
  services = {
    udisks2.enable = true;
    stubby.enable = true;
  };
  system.autoUpgrade = {
    enable = true;
    dates = "12:00";
  };
  time.timeZone = "America/Costa_Rica";
}
