{ config, pkgs, ... }: {
  environment = {
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      vimdiff = "nvim -d";
    };
  };
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      extraConfig = ''
      '';
      plugins = with pkgs.vimPlugins; [
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
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
    };
  };
}
