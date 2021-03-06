{ config, pkgs, ... }: {
  fonts = {
    enableFontDir = true;
    fontconfig = {
      enable = true;
      defaultFonts = { monospace = [ "Fira Code Nerd Font" ]; };
    };
    fonts = with pkgs; [
      dejavu_fonts
      emacs-all-the-icons-fonts
      fira-code
      fira-code-symbols
      font-awesome
      nerdfonts
    ];
  };
}
