_: {
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.flavour = "mocha";
    globals.mapleader = " ";
    maps = {normal = {"<leader>w".action = "<cmd>w<CR>";};};
    plugins.lualine.enable = true;
    plugins.treesitter = {
      enable = true;
      folding = true;
    };
    plugins = {
      treesitter-rainbow = {enable = true;};
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          yamlls.enable = true;
        };
      };
      lsp-format.enable = true;
    };
  };
  xdg.configFile."nvim/lua" = {
    enable = true;
    recursive = true;
    source = ./lua;
  };
}
