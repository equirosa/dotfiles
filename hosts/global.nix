{ pkgs, lib, ... }: {
  nix = {
    registry = {
      nixpkgs.to = {
        type = "path";
        inherit (pkgs) path;
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
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "beeper"
      "steam"
      "steam-original"
      "steam-run"
      "steam-runtime"
      "vscode"
    ];
}
