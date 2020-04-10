{ config, lib, pkgs, ... }: {
  imports = [
    <home-manager/nixos>
    ./misc/32bit.nix
    ./editors/neovim.nix
    ./window-managers/xorg/awesome.nix
    ./emacs.nix
    ./location.nix
    ./theme.nix
    ./printing.nix
    ./tor.nix
    ./audio.nix
    ./flatpak.nix
    ./fonts.nix
    ./browsers/firefox.nix
    ./kdeConnect.nix
  ];
  home-manager.users.eduardo = { pkgs, ... }: {
    programs = {
      bash = {
        enable = true;
        historyControl = [ "erasedups" ];
        historyFile = "$XDG_CACHE_HOME/bash_history";
        historyIgnore = [ "ls" "cd" "exit" ];
      };
      keychain = {
        enable = true;
        enableBashIntegration = true;
        agents = [ "ssh" ];
        keys = [ "sourcehut" "github" "gitlab" "codeberg" ];
      };
      lsd = {
        enable = true;
        enableAliases = true;
      };
      pazi = {
        enable = true;
        enableBashIntegration = true;
      };
      starship = {
        enable = true;
        enableBashIntegration = true;
        settings = {
          battery = {
            full_symbol = "";
            charging_symbol = "";
            discharging_symbol = "";
          };
          git_branch.symbol = " ";
          golang.symbol = " ";
          haskell.symbol = " ";
          nix_shell.symbol = " ";
          package.symbol = " ";
          python.symbol = " ";
          rust.symbol = " ";
        };
      };
    };
    xdg.enable = true;
  };
  environment = {
    shellAliases = {
      # Cleanup
      nvidia-settings="nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings";
      startx="startx '$XDG_CONFIG_HOME/x11/xinitrc'";

      # Replacements
      cat = "bat -p";
      fd = "fd -I";
      find = "fd";
      ls = "exa";
      l = "exa -lh";

      # Torifying all the things
      aerc = "torify aerc";
      git = "torify git";
      lazygit = "torify lazygit";

      # Shortening some things
      c = "cd";
      dateh = "date --help | rg %";
      g = "git";
      gcp = "git commit -a; git push";
      lg = "lazygit";
      nrebuild = "sudo nixos-rebuild switch --upgrade";
      nsearch = "nix-env -qaP --description";
    };
    variables = {
      # Cleanup
      GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
      IDEA_PROPERTIES="$XDG_CONFIG_HOME/intellij-idea/idea.properties";
      IDEA_VM_OPTIONS="$XDG_CONFIG_HOME/intellij-idea/idea64.vmoptions";
      LESSHISTFILE="-"; # Disable less history file
      UNISON="$XDG_DATA_HOME/unison";
      XCOMPOSEFILE="$XDG_CONFIG_HOME/X11/xcompose";
      XCOMPOSECACHE="$XDG_CACHE_HOME/X11/xcompose";
      ZDOTDIR="$XDG_CONFIG_HOME/zsh";

      # Custom stuff
      PATH="$XDG_DATA_HOME/scripts:$PATH";
      BROWSER="qutebrowser";
      EDITOR="vim";
      FILE="lf";
      IMG="imv";
      MAIL="aerc";
      READER="zathura";
      TERMINAL="kitty";
      LOCK_CMD="i3lock-fancy -p";
      LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.cpp=ﭱ:*.js=:*.vimrc=:*.vim=:*.nix=:*.css=:*.pdf=:*.html=:*.rs=:*.rlib=:*.7z=:*.zip=:*.tar=:*.lz=:*.git=:*.webm=:*.mp4=:*.flac=:*.deb=:*.rpm=:*.py=:*.md=:*.json=:*.mkv=:*.go=:.git=";

      # 'Less' stuff
      LESS="-R";
      LESS_TERMCAP_mb="$(printf '%b' '[1;31m')";
      LESS_TERMCAP_md="$(printf '%b' '[1;36m')";
      LESS_TERMCAP_me="$(printf '%b' '[0m')";
      LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')";
      LESS_TERMCAP_se="$(printf '%b' '[0m')";
      LESS_TERMCAP_us="$(printf '%b' '[1;32m')";
      LESS_TERMCAP_ue="$(printf '%b' '[0m')";
    };
  };
  hardware = {
    cpu.intel.updateMicrocode = true;
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
      #### Backups ####
      restic

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

      #### Dev Stuff ####
      gitAndTools.gitFull

      #### FAH Stuff :) ####
      fahviewer
      fahcontrol

      #### File Management ####
      atool # Makes handling compression easier
      exa # 'ls' replacement
      lf # Terminal file manager
      file # used to get file type
      glow # Prettify markdown
      highlight # Prettify the rest
      mediainfo # prints info of media binary files
      p7zip
      zip
      unzip
      lzip
      w3m # it's a browser but i use it to display images in lf

      #### File Transfer ####
      croc # Sync file transfer
      ffsend # Async file transfer

      #### TODO: Sort these... ####
      udiskie
      bat
      htop
      gotop
      calc # calculator
      fd # replacement for 'find'
      imv # Image viewer
      drive # stuff that i use to make Google drive less unbearable
      gopass # Password Manager
      ispell # spellchecking
      keychain # Fewer password prmpts
      lazygit # git for lazy people
      libnotify # Notification stuff
      lf # Terminal file manager
      mpv # Video Player
      perl530Packages.FileMimeInfo # mimetype stuff
      poppler_utils # reading PDFs
      ripgrep # grep but faster
      spaceFM # Graphical file manager
      speedtest-cli
      starship # pretty prompt
      toot # Mastodon client
      transmission
      transmission-remote-cli
      trash-cli # Trash files
      youtube-dl
      zathura # Doc viewer

      #### Nixpkgs stuff
      nix-prefetch-git
      nix-prefetch-github
      nixfmt
      nox
      vgo2nix

      #### Org mode things ####
      texlive.combined.scheme-full # LaTeX stuff

      #### Rust Dev ####
      cargo

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

      #### Utilities ####
      alacritty
      kitty
    ];
    #shell = pkgs.fish;
  };
  nix.autoOptimiseStore = true;
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: super: {
        vim =
          super.vim.override { plugins = with pkgs.vimPlugins; [ vim-nix ]; };
      })
    ];
  };
  programs = {
    dconf.enable = true;
    firejail = {
      enable = true;
      wrappedBinaries = { zoom-us = "${lib.getBin pkgs.zoom-us}/bin/zoom-us"; };
    };
    gnome-disks.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    spacefm.enable = true;
    thefuck.enable = true;
    udevil.enable = true;
  };
  services = {
    stubby.enable = true;
    foldingathome.enable = true;
  };
  system.autoUpgrade = {
    enable = true;
    dates = "0/4:*:*";
  };
  time.timeZone = "America/Costa_Rica";
}
