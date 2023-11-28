{
  description = "Kiri's Nix configuration";

  inputs = {
    devshell.url = "github:numtide/devshell";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
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
    inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "x86_64-darwin" ];
      imports = [
        inputs.devshell.flakeModule
        inputs.nixos-flake.flakeModule
        ./users
        ./home
        ./nixos
        ./nix-darwin
      ];
      flake = {
        colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
        nixosConfigurations = {
          snowfort = self.nixos-flake.lib.mkLinuxSystem {
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
          };
        };
        darwinConfigurations = { };
      };
      perSystem = { config, pkgs, ... }: {
        devShells.default = {
          packages = with pkgs; [
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
        formatter = pkgs.treefmt;
      };
    };
}
