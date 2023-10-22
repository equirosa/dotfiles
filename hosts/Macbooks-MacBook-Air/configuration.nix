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
  users.users.eduardo.packages = with pkgs; [ direnv wormhole-rs ];
  nixpkgs.hostPlatform = "x86_64-darwin";
  services.nix-daemon.enable = true;
}
