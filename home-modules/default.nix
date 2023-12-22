{ pkgs, lib, ... }: {
  imports = [
    ./kitty.nix
    ./neovim
  ];
  home.packages = lib.attrValues {
    inherit (pkgs)
      # Browsers
      firefox
      mullvad-browser
      # Utilities
      git
      lazygit
      ripgrep
      tree
      wl-clipboard
      ;
  };
  programs = {
    bash.enable = true;
    starship.enable = true;
  };
}
