_: {
  programs.nixvim = {
    enable = true;
    clipboard.providers.wl-copy.enable = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
    globals.mapleader = " ";
    maps = {
      normal = {
        "<leader>gg".action = ":Neogit<CR>";
        "<leader>w".action = "<cmd>w<CR>";
        "<C-h>".action = ":wincmd h<CR>";
        "<C-j>".action = ":wincmd j<CR>";
        "<C-k>".action = ":wincmd k<CR>";
        "<C-l>".action = ":wincmd l<CR>";
      };
    };
    plugins.lualine.enable = true;
    plugins.treesitter = {
      enable = true;
      folding = true;
    };
    plugins = {
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          rust-analyzer.enable = true;
          nil_ls.enable = true;
          yamlls.enable = true;
        };
      };
      lsp-format.enable = true;
      lsp-lines.enable = true;
      neogit.enable = true;
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
      which-key = {enable = true;};
    };
  };
  xdg.configFile."nvim/lua" = {
    enable = true;
    recursive = true;
    source = ./lua;
  };
}
