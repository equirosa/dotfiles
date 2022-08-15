{ config
, pkgs
, ...
}: {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
  home-manager.users.kiri = {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      extraPackages = [ ] ++ import ./editorPackages.nix { inherit pkgs; };
      extraConfig = ''
        lua ./init.lua
      '';
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = false;
      withRuby = false;
    };
  };
}
