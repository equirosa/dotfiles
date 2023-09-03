{ pkgs, lib, ... }: {
  programs.nixvim = {
    enable = true;
    clipboard.providers.wl-copy.enable = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      integrations = {
        lsp_saga = true;
        native_lsp.enabled = true;
        cmp = true;
        markdown = true;
        neogit = true;
        telescope = true;
        treesitter = true;
        ts_rainbow2 = true;
        which_key = true;
      };
      terminalColors = true;
      transparentBackground = true;
    };
    globals.mapleader = " ";
    options = {
      hlsearch = false;
      number = true;
      relativenumber = true;
      smartcase = true;
      ignorecase = true;
    };
    maps = {
      normal = {
        "<M-k>".action = ":m -2<CR>"; # Move line up
        "<M-j>".action = ":m +1<CR>"; # Move line down
      };
      visual = {
        "<M-k>".action = ":m '<-2<CR>gv=gv"; # Move line up
        "<M-j>".action = ":m '>+1<CR>gv=gv"; # Move line down
      };
      normalVisualOp = {
        "<C-h>".action = ":wincmd h<CR>";
        "<C-j>".action = ":wincmd j<CR>";
        "<C-k>".action = ":wincmd k<CR>";
        "<C-l>".action = ":wincmd l<CR>";
        "<leader>e".action = ":Telescope file_browser<CR>";
        "<leader>gg".action = ":Neogit<CR>";
        "<leader>ra".action = ":!regen all<CR>";
        "<leader>rh".action = ":!regen home<CR>";
        "<leader>ro".action = ":!regen os<CR>";
        "<leader>w".action = ":w<CR>";
      };
      visualOnly = { "<C-s>".action = ":sort<CR>"; };
    };
    plugins = {
      comment-nvim.enable = true;
      lualine.enable = true;
      lsp = {
        enable = true;
        servers = {
          cssls.enable = true;
          bashls.enable = true;
          elmls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          lua-ls.enable = true;
          nil_ls.enable = true;
          nixd.enable = true;
          pylsp.enable = true;
          rust-analyzer.enable = true;
          texlab.enable = true;
          yamlls.enable = true;
        };
      };
      lspkind = {
        enable = true;
        cmp.enable = true;
      };
      lspsaga.enable = true;
      lsp-format.enable = true;
      lsp-lines.enable = true;
      luasnip.enable = true;
      neogit.enable = true;
      nvim-autopairs = { enable = true; checkTs = true; };
      nvim-cmp = {
        enable = true;
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            modes = [ "i" "s" ];
            action = lib.fileContents ./tabcycle.lua;
          };
        };
        snippet.expand = "luasnip";
        sources = [
          { name = "buffer"; }
          { name = "luasnip"; } #For luasnip users.
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_document_help"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "nvim_lua"; }
          { name = "path"; }
          { name = "treesitter"; }
        ];
      };
      nvim-colorizer.enable = true;
      treesitter = {
        enable = true;
        nixvimInjections = true;
      };
      treesitter-context.enable = true;
      treesitter-refactor = {
        enable = true;
        navigation = {
          enable = true;
          keymaps = {
            gotoDefinition = "<leader>gd";
            gotoNextUsage = "<leader>gn";
            gotoPreviousUsage = "<leader>gp";
            listDefinitons = "<leader>ld";
            listDefinitonsToc = "<leader>gO";
          };
        };
      };
      ts-context-commentstring.enable = true;
      telescope = {
        enable = true;
        extensions = {
          frecency.enable = true;
          file_browser = {
            enable = true;
            hijackNetrw = true;
          };
          fzf-native.enable = true;
        };
        keymaps = {
          "<leader><space>" = "buffers";
          "<leader>sd" = "diagnostics";
          "<leader>sf" = "find_files";
          "<leader>sg" = "live_grep";
          "<leader>sh" = "help_tags";
          "<leader>gr" = "lsp_references";
          "<leader>sk" = "keymaps";
          "<leader>sw" = "grep_string";
        };
      };
      treesitter-rainbow.enable = true;
      which-key = { enable = true; };
    };
    extraConfigLua = lib.fileContents ./init.lua;
    extraPackages = with pkgs; [ nixpkgs-fmt ];
    extraPlugins = with pkgs.vimPlugins; [ boole-nvim ];
  };
}
