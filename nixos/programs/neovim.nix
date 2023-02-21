{ config
, pkgs
, lib
, vimUtils
, fileContents
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
in
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [ ];
    extraConfig = ''
      lua << EOF
      ${lib.fileContents ../../nvim/init.lua}
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      packer-nvim
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = false;
    withRuby = false;
  };
}
