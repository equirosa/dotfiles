{ config, pkgs, ... }: {
  fonts = {
    enableFontDir = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Fira Code" ];
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
      };
    };
    fonts = with pkgs; [
      fira-code
      fira-code-symbols
      font-awesome
      liberation_ttf
      mplus-outline-fonts
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      ubuntu_font_family
    ];
  };
}
