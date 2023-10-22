{ pkgs, ... }: {
  imports = [ ../global.nix ];
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [ "beeper" "bitwarden" "librewolf" ];
  };
  users.users.kiri.packages = with pkgs; [ direnv git lazygit ];
  programs.zsh.enable = true;
  services.nix-daemon.enable = true;
}
