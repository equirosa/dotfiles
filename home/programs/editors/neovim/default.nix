{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs;[ gcc gnumake ];
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
