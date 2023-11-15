{ pkgs, ... }: {
  nix = {
    registry = {
      nixpkgs.to = {
        type = "path";
        path = pkgs.path;
      };
    };
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
}
