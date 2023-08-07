{ pkgs, ... }: {
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Fira Code" "FiraCode Nerd Font" "Twitter Color Emoji" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      dejavu_fonts
      emacs-all-the-icons-fonts
      fira-code
      font-awesome
      iosevka-comfy.comfy
      liberation_ttf
      twitter-color-emoji
    ];
  };
}
