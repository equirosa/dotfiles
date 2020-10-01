{ config, pkgs, ... }: {
  environment = {
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      vimdiff = "nvim -d";
    };
    systemPackages = with pkgs;
      [
        (
          neovim.override {
            viAlias = true;
            vimAlias = true;
            configure = {
              packages.myPlugins = with pkgs.vimPlugins; {
                start = [
                  auto-pairs
                  bclose-vim
                  fugitive
                  gruvbox-community
                  lf-vim
                  nerdcommenter
                  lightline-vim
                  vim-automkdir
                  vim-devicons
                  vim-surround
                  # CoC
                  coc-nvim # Main one
                  fzf-vim # Fzf integration for Vim
                  coc-fzf # Fzf integration for CoC
                  coc-vimlsp # VimScript integration for CoC
                  coc-prettier # formatting
                  # Syntax highlighting
                  rainbow
                  vim-css-color
                  vim-polyglot
                ];
                opt = [];
              };
              customRC = "so /home/eduardo/.config/nvim/init.vim";
            };
          }
        )
      ];
  };
}
