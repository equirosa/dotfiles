{
  config,
  pkgs,
  ...
}: {
  home-manager.users.kiri = {
    programs.neovim = {
      enable = true;
      extraPackages = [] ++ import ./editorPackages.nix {inherit pkgs;};
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
