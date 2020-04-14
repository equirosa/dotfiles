{ config, pkgs, ... }: {
  fonts = {
    enableFontDir = true;
    fontconfig = {
      enable = true;
      defaultFonts = { monospace = [ "Fira Code Nerd Font" ]; };
    };
    fonts = with pkgs; [
      emacs-all-the-icons-fonts
      fira-code-symbols
      font-awesome
      nerdfonts
    ];
  };
}
