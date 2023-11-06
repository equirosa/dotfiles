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
}
