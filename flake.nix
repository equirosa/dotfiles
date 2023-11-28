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
    inputs@{ flake-utils
    , home-manager
    , nix-colors
    , nix-darwin
    , nix-index-database
    , nixpkgs
    , ...
    }:
    let
      colors = import ./colors.nix;
      overlays = with inputs; [
        emacs-overlay.overlay
        nur.overlay
      ];
      common-hm-config = {
        backupFileExtension = "hmBackup";
        useGlobalPkgs = true;
        useUserPackages = true;
      };
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
            stylua
            vscode-langservers-extracted
          ];
        };
        formatter = nixpkgs.legacyPackages.${system}.treefmt;
      })
    // {
      nixosConfigurations.snowfort = nixpkgs.lib.nixosSystem {
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
            home-manager = common-hm-config // {
              extraSpecialArgs = { inherit colors inputs; };
              users.kiri = { osConfig, ... }: {
                imports = [
                  ./home/linux.nix
                  nix-index-database.hmModules.nix-index
                  inputs.nixvim.homeManagerModules.nixvim
                  nix-colors.homeManagerModules.default
                ];
                colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
                home.stateVersion = osConfig.system.stateVersion;
              };
            };
          }
        ];
        specialArgs = { inherit colors inputs; };
      };
      darwinConfigurations.MacBook-Air-de-Eduardo = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/Macbooks-MacBook-Air/configuration.nix
          { nixpkgs.overlays = overlays; }
          home-manager.darwinModules.home-manager
          {
            home-manager = common-hm-config // {
              extraSpecialArgs = { inherit colors inputs; };
              users.kiri = { lib, ... }: {
                imports = [
                  nix-index-database.hmModules.nix-index
                  ./home
                ];
                home = {
                  username = "kiri";
                  homeDirectory = lib.mkForce "/Users/kiri";
                  stateVersion = "23.11";
                };
              };
            };
          }
        ];
      };
    };
}
