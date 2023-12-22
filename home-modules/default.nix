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
      wl-clipboard
      ;
  };
  programs = {
    bash.enable = true;
    starship.enable = true;
  };
}
