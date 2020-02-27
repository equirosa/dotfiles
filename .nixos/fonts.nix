{ config, pkgs, ... }: {
  fonts = {
    enableFontDir = true;
    fontconfig = {
      enable = true;
      defaultFonts = { monospace = [ "Fira Code" ]; };
    };
    fonts = with pkgs; [ fira-code font-awesome nerdfonts ];
  };
}
