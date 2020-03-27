{ config, pkgs, ... }: {
  fonts = {
    enableFontDir = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Fira Code" ];
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    fonts = with pkgs; [
      emacs-all-the-icons-fonts
      fira-code
      fira-code-symbols
      font-awesome
      liberation_ttf
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      ubuntu_font_family
    ];
  };
}
