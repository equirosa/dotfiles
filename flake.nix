{
  description = "Kiri's Nix configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs @ {
    self,
    flake-utils,
    nixpkgs,
    home-manager,
    nur,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          alejandra
          shfmt
          stylua
          nodePackages.bash-language-server
        ];
      };
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
                extraSpecialArgs = []; # to pass arguments to home.nix
              };
            }
          ];
        };
      };
    });
}
