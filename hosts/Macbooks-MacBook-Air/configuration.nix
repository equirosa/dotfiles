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
  nixpkgs.hostPlatform = "x86_64-darwin";
  users.users.kiri.packages = with pkgs; [ direnv nixpkgs-fmt shfmt git lazygit ];
  services.nix-daemon.enable = true;
}
