{ inputs, lib, ... }: {
  imports = [
    ./audio.nix
    ./fonts.nix
    ./gaming.nix
  ];
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  programs.adb.enable = true;

  programs.gnupg.agent.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    permitCertUid = "kiri";
    openFirewall = true;
  };

  users.users.kiri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" ]; # Enable ‘sudo’ for the user.
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "beeper"
    "steam"
    "steam-original"
    "steam-run"
  ];
}
