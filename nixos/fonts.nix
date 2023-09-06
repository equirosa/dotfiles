{ pkgs, ... }: {
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Iosevka Comfy" "Iosevka Comfy Duo" "FiraCode Nerd Font" ];
    };
    fontDir.enable = true;
    packages = with pkgs; [
      dejavu_fonts
      emacs-all-the-icons-fonts
      font-awesome
      iosevka-comfy.comfy
      iosevka-comfy.comfy-duo
      liberation_ttf
      nerdfonts
      noto-fonts-emoji
    ];
  };
}
