{ config, pkgs, ... }: {
  environment = {
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      vimdiff = "nvim -d";
    };
    systemPackages = with pkgs; [
      (neovim.override {
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
        YouCompleteMe
        # Syntax highlighting
        vim-css-color
        vim-polyglot
            ];
            opt = [];
          };
        };
      })
    ];
  };
}
