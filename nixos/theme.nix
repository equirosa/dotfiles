{pkgs, ...}: {
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Fira Code" "FiraCode Nerd Font" "Twitter Color Emoji"];
        emoji = ["Twitter Color Emoji"];
      };
    };
    fontDir.enable = true;
    fonts = with pkgs; [
      dejavu_fonts
      emacs-all-the-icons-fonts
      fira-code
      font-awesome
      liberation_ttf
      (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
      twitter-color-emoji
    ];
  };
}
