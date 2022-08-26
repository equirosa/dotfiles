{ config
, pkgs
, ...
}: {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
  home-manager.users.kiri = {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      extraPackages = with pkgs; [ gcc gnumake ] # Needed for Treesitter and telescope-fzf-native
        ++ import ./editorPackages.nix { inherit pkgs; };
      extraConfig = ''
        lua << EOF
        ${builtins.readFile (builtins.fetchurl {
            url = "https://raw.githubusercontent.com/equirosa/nvim-config/master/init.lua";
            })}
        EOF
      '';
      plugins = with pkgs.vimPlugins; [
        vim-fugitive
      ];
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = false;
      withRuby = false;
    };
  };
}
