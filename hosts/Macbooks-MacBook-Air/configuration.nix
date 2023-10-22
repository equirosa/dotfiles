{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [ "beeper" "bitwarden" "librewolf" ];
  };
  nix = {
    extraOptions = ''
      experimental-features = flakes nix-command recursive-nix
      keep-outputs = true
      keep-derivations = true
    '';
    settings = {
      auto-optimise-store = true;
      sandbox = true;
    };
  };
  users.users.kiri.packages = with pkgs; [ direnv nixpkgs-fmt shfmt git lazygit ];
  programs.zsh.enable = true;
  services.nix-daemon.enable = true;
}
