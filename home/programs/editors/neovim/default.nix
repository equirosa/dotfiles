{
  pkgs,
  lib,
  vimUtils,
  ...
}: let
  inherit (lib) fileContents;
  pluginGit = ref: repo:
    vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        inherit ref;
      };
    };
  pluginLatest = pluginGit "HEAD";
in {
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
        servers = {nil_ls.enable = true;};
      };
    };
  };
  xdg.configFile."nvim/lua" = {
    enable = true;
    recursive = true;
    source = ./lua;
  };
}
