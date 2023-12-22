{ inputs, ... }: {
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

  users.users.kiri = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
}
