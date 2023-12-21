{ pkgs, ... }: {
  imports = [ ../global.nix ];
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [ "beeper" "bitwarden" "libreoffice" "librewolf" "mullvad-browser" "thunderbird" ];
  };
  users.users.kiri.packages = with pkgs; [ direnv git lazygit ];
  programs.zsh.enable = true;
  services.nix-daemon.enable = true;
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
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
