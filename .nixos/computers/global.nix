{ config, pkgs, ... }: {
  imports = [
    <home-manager/nixos>
    ../audio.nix
    ../bat.nix
    ../flatpak.nix
    ../fonts.nix
    ../git.nix
    ../location.nix
    ../lf.nix
    ../printing.nix
    ../theme.nix
    ../tor.nix
    #### User Stuff ####
    ../eduardo.nix
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
