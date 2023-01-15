{ config
, pkgs
, lib
, vimUtils
, ...
}:
let
  pluginGit = ref: repo: vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      inherit ref;
    };
  };
  pluginGitHead = pluginGit "HEAD";
in
{
  programs.neovim = {
    package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [ ];
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
}
