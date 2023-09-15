{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    extraPackages = [ pkgs.gnumake ];
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
