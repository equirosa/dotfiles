{
  description = "Kiri's Nix configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hypr-contrib.inputs.nixpkgs.follows = "nixpkgs";
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:pta2002/nixvim";
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs @ {
    flake-utils,
    home-manager,
    hyprland,
    nix-gaming,
    nix-index-database,
    nixpkgs,
    nixvim,
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
        ];
      };
      formatter = nixpkgs.legacyPackages.${system}.treefmt;
    })
    // {
      nixosConfigurations = {
        snowfort = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            hyprland.nixosModules.default
            {
              programs.hyprland.enable = true;
              security.pam.services.swaylock = {};
            }
            ./hosts/snowfort/configuration.nix
          ];
          specialArgs = {inherit colors nix-gaming nixpkgs;};
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
            nix-index-database.hmModules.nix-index
            nixvim.homeManagerModules.nixvim
            {programs.nix-index-database.comma.enable = true;}
            {programs.nix-index.enable = true;}
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
