{ config
, pkgs
, ...
}: {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
  home-manager.users.kiri = {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      extraPackages = with pkgs;
        [ ] # Needed for Teesitter
        ++ import ./editorPackages.nix { inherit pkgs; };
      extraConfig = ''
        lua << EOF
        ${builtins.readFile ../../nvim/init.lua}
        EOF
      '';
      plugins = with pkgs.vimPlugins; [
        packer-nvim
        telescope-fzf-native-nvim
        vim-fugitive
        (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
        nvim-ts-rainbow
        nvim-treesitter-textobjects
        nvim-treesitter-refactor
        nvim-treesitter-context
      ];
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = false;
      withRuby = false;
    };
  };
}
