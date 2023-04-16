{
  description = "Kiri's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
  };

  outputs =
    inputs @
    { self
    , flake-utils
    , nixpkgs
    , home-manager
    , nur
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system}; in
    {
      devShells.default = import ./shell.nix { inherit pkgs; };
      formatter = nixpkgs.legacyPackages.${system}.treefmt;
      nixosConfigurations = {
        snowfort = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            /etc/nixos/configuation.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kiri = import ./home.nix;
              };
            }
          ];
        };
      };
    });
}
