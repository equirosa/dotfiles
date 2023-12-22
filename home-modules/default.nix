{ pkgs, lib, ... }: {
  imports = [ ./kitty.nix ];
  home.packages = lib.attrValues {
    inherit (pkgs)
      # Browsers
      firefox
      mullvad-browser
      # Utilities
      git
      lazygit
      ripgrep
      neovim
      tree
      ;
  };
  programs = {
    bash.enable = true;
  };
}
