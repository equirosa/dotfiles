{ pkgs, lib, ... }: {
  imports = [
    ./kitty.nix
    ./neovim
  ];
  home.packages = lib.attrValues {
    inherit (pkgs)
      beeper
      thunderbird
      # Browsers
      firefox
      mullvad-browser
      # Utilities
      libreoffice
      git
      lazygit
      fd
      ripgrep
      tree
      wl-clipboard
      ;
  };
  programs = {
    bash.enable = true;
    starship.enable = true;
  };
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "beeper"
  ];
}
