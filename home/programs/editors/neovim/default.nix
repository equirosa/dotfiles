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
    colorschemes.onedark.enable = true;
    globals.mapleader = " ";
    maps = {normal = {"<leader>w".action = "<cmd>w<CR>";};};
    plugins.lualine.enable = true;
    plugins.treesitter.enable = true;
  };
  xdg.configFile."nvim/lua" = {
    enable = true;
    recursive = true;
    source = ./lua;
  };
}
