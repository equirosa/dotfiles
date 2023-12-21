{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      dejavu_fonts
      font-awesome
      iosevka-comfy.comfy
      liberation_ttf
      nerdfonts
      noto-fonts-emoji
    ];
  };
}
