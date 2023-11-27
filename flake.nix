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
        nixosConfigurations = { };
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
