{ pkgs, ... }: {
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Iosevka Comfy" "FiraCode Nerd Font" "Twitter Color Emoji" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
    fontDir.enable = true;
    packages = with pkgs; [
      dejavu_fonts
      emacs-all-the-icons-fonts
      font-awesome
      iosevka-comfy.comfy
      liberation_ttf
      nerdfonts
      twitter-color-emoji
    ];
  };
}
