{ pkgs, ... }: {
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Iosevka Comfy" "FiraCode Nerd Font" ];
    };
    fontDir.enable = true;
    packages = with pkgs; [
      dejavu_fonts
      emacs-all-the-icons-fonts
      font-awesome
      iosevka-comfy.comfy
      liberation_ttf
      nerdfonts
      noto-fonts-emoji
    ];
  };
}
