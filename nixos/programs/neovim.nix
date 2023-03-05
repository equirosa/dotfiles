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
  pluginLatest = pluginGit "HEAD";
  inherit (lib) fileContents;
in
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [ ];
    extraConfig = ''
      lua << EOF
      ${fileContents ../../nvim/init.lua}
      EOF
    '';
    plugins = with pkgs.vimPlugins; [ # Plugins managed directly by Nix
      nvim-treesitter.withAllGrammars # So it is compiled on system rebuild
      lazy-nvim # To avoid bootstrapping
      lazy-lsp-nvim # This already calls a nix shell anyway so might as well stick it here
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = false;
    withRuby = false;
  };
}
