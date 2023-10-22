{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      gcc
      gnumake
      nodejs_20
      # LSPs
      nil
      # search
      ripgrep
    ];
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
