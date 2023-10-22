{
  description = "Kiri's Nix configuration";

  inputs = {
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hypr-contrib.inputs.nixpkgs.follows = "nixpkgs";
    hypr-contrib.url = "github:hyprwm/contrib";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nur.url = "github:nix-community/NUR";
    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { emacs-overlay
    , flake-utils
    , home-manager
    , hypr-contrib
    , nix-colors
    , nix-darwin
    , nix-gaming
    , nix-index-database
    , nixpkgs
    , nixvim
    , nur
    , wrapper-manager
    , ...
    }:
    let
      colors = import ./colors.nix;
      overlays = [
        emacs-overlay.overlay
        nur.overlay
      ];
    in
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            deadnix
            lua-language-server
            nixpkgs-fmt
            nodePackages.bash-language-server
            shellharden
            shfmt
            vscode-langservers-extracted
          ];
        };
        formatter = nixpkgs.legacyPackages.${system}.treefmt;
      })
    // {
      nixosConfigurations = {
        snowfort = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              programs.hyprland.enable = true;
              security.pam.services.swaylock = { };
              nixpkgs.overlays = overlays;
              nix.settings = {
                substituters = [
                  "https://nix-gaming.cachix.org"
                  "https://nix-community.cachix.org"
                  "https://hyprland.cachix.org"
                  "https://cache.nixos.org/"
                ];
                trusted-public-keys = [
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
                  "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                ];
              };
            }
            ./hosts/snowfort/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit colors hypr-contrib nix-colors wrapper-manager overlays; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kiri = { osConfig, ... }: {
                  imports = [
                    ./home
                    nix-index-database.hmModules.nix-index
                    nixvim.homeManagerModules.nixvim
                    nix-colors.homeManagerModules.default
                  ];
                  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
                  home.stateVersion = osConfig.system.stateVersion;
                };
              };
            }
          ];
          specialArgs = { inherit colors nix-gaming nixpkgs; };
        };
      };
      darwinConfigurations.MacBook-Air-de-Eduardo = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/Macbooks-MacBook-Air/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit colors hypr-contrib nix-colors wrapper-manager overlays; };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kiri = { osConfig, lib, ... }: {
                imports = [
                  ./home/programs/editors/neovim
                  ./home/programs/terminal
                ];
                home.stateVersion = "23.11";
                home = {
                  username = "kiri";
                  homeDirectory = lib.mkForce "/Users/kiri";
                };
              };
            };
          }
        ];
      };
    };
}
