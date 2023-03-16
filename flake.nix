{
  description = "Kiri's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };

  outputs =
    inputs @
    { self
    , flake-utils
    , devshell
    , nixpkgs
    , home-manager
    , nur
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system}; in
    {
      devShells.default = import ./shell.nix {inherit pkgs;};
      formatter = nixpkgs.legacyPackages.${system}.treefmt;
      nixosConfigurations = {
        snowfort = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
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
