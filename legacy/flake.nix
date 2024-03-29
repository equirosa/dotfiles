{
  description = "Kiri's Nix configuration";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
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
    inputs@{ self
    , agenix
    , flake-utils
    , home-manager
    , nix-colors
    , nix-darwin
    , nix-index-database
    , nixpkgs
    , pre-commit-hooks
    , treefmt-nix
    , ...
    }:
    let
      colors = import ./colors.nix;
      overlays = with inputs; [
        emacs-overlay.overlay
        nur.overlay
      ];
    in
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      {
        devShells.default = pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = with pkgs; [
            lua-language-server
            nixpkgs-fmt
            nodePackages.bash-language-server
            shellharden
            stylua
            vscode-langservers-extracted
          ];
        };
        formatter = treefmtEval.config.build.wrapper;
        checks = {
          formatting = treefmtEval.config.build.check self;
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = { };
          };
        };
      })
    // {
      nixosConfigurations.snowfort =
        let
          system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            agenix.nixosModules.default
            {
              programs.hyprland.enable = true;
              security.pam.services.swaylock = { };
              nixpkgs.overlays = overlays;
              nix.settings = {
                builders-use-substitutes = true;
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
                  home.packages = [ agenix.packages.${system}.default ];
                };
              };
            }
          ];
          specialArgs = { inherit colors inputs; };
        };
      darwinConfigurations.MacBook-Air-de-Eduardo = nix-darwin.lib.darwinSystem
        {
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
