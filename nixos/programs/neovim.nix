{
  config,
  pkgs,
  ...
}: {
  home-manager.users.kiri = {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim;
      extraPackages = with pkgs;
        [gcc] # Needed for Treesitter
        ++ import ./editorPackages.nix {inherit pkgs;};
      extraConfig = ''
        lua << EOF
        ${builtins.readFile ../../nvim/init.lua}
        EOF
      '';
      plugins = with pkgs.vimPlugins; [
        telescope-fzf-native-nvim
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
