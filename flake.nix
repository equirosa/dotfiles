{
  description = "Kiri's Nix configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs @ {
    flake-utils,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  }: let
    colors = import ./colors.nix;
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          alejandra
          deadnix
          shfmt
          stylua
        ];
      };
      formatter = nixpkgs.legacyPackages.${system}.treefmt;
    })
    // {
      nixosConfigurations = {
        snowfort = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [./hosts/snowfort/configuration.nix];
          specialArgs = {inherit colors nixpkgs;};
        };
      };
      homeConfigurations = let
        inherit (home-manager.lib) homeManagerConfiguration;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        main = homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {inherit colors inputs;}; # to pass arguments to home.nix
          modules = [
            hyprland.homeManagerModules.default
            inputs.nix-index-database.hmModules.nix-index
            {programs.nix-index-database.comma.enable = true;}
            {
              home = {
                username = "kiri";
                homeDirectory = "/home/kiri";
                stateVersion = "22.05";
              };
              xdg.userDirs.enable = true;
            }
            ./home
          ];
        };
      };
    };
}
