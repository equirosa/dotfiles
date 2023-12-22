{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = lib.attrValues {
      inherit (pkgs)
        gcc
        gnumake
        nodejs_20
        # LSPs
        nil
        # search
        ripgrep
        ;
    };
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  xdg.configFile."nvim" = {
    source = ./config;
    # onChange = "";
    recursive = true;
  };
}
