{
  description = "Kiri's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = inputs @ {
    self,
    flake-utils,
    devshell,
    nixpkgs,
    home-manager,
  }:
    flake-utils.lib.eachDefaultSystem (system: {
      formatter = nixpkgs.legacyPackages.${system}.treefmt;
      devShell = let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [devshell.overlay];
        };
      in
        pkgs.devshell.mkShell {
          imports = [(pkgs.devshell.importTOML ./devshell.toml)];
        };
    });
}
