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
    colorschemes.gruvbox.enable = true;
    plugins.lualine.enable = true;
  };
  programs.neovim = {
    enable = false;
    extraConfig = ''
      lua << EOF
      ${fileContents ./init.lua};
      EOF
    '';
    extraPackages = with pkgs; [gcc gnumake];
    plugins = with pkgs.vimPlugins; [
      # Plugins managed directly by Nix
      lazy-nvim # To avoid bootstrapping
      lazy-lsp-nvim # This already calls a nix shell anyway so might as well stick it here
      nvim-treesitter.withAllGrammars
      parinfer-rust
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };
  xdg.configFile."nvim/lua" = {
    enable = true;
    recursive = true;
    source = ./lua;
  };
}
