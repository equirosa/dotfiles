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
    extraConfig = ''
      lua << EOF
      ${fileContents ./neovim-config/init.lua};
      EOF
    '';
    extraPackages = with pkgs; [ gcc gnumake ];
    plugins = with pkgs.vimPlugins; [
      # Plugins managed directly by Nix
      lazy-nvim # To avoid bootstrapping
      lazy-lsp-nvim # This already calls a nix shell anyway so might as well stick it here
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
    source = ./neovim-config/lua;
  };
}
