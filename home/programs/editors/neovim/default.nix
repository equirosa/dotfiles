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
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          yamlls.enable = true;
        };
      };
      lsp-format.enable = true;
      lsp-lines.enable = true;
      telescope = {
        enable = true;
        extensions = {
          frecency.enable = true;
          fzf-native.enable = true;
        };
        keymaps = {
          "<leader>sd" = "diagnostics";
          "<leader>sf" = "find_files";
          "<leader>sg" = "live_grep";
          "<leader>sh" = "help_tags";
          "<leader>sk" = "keymaps";
          "<leader>sw" = "grep_string";
        };
      };
      treesitter-rainbow = {enable = true;};
    };
  };
  xdg.configFile."nvim/lua" = {
    enable = true;
    recursive = true;
    source = ./lua;
  };
}
