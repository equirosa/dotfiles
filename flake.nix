{
  description = "Kiri's Nix configs";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    # If you're going to use darwinConfigurations uncomment next two inputs
    # Otherwise you can remove them
    # nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    # darwin = {
    #   url = "github:lnl7/nix-darwin/master";
    #   inputs.nixpkgs.follows = "nixpkgs-darwin";
    # };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };

  outputs = inputs@{ flake-parts, ez-configs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ez-configs.flakeModule
      ];

      # mkFlake expects this to be present,
      # so even if we don't use anything from perSystem, we need to set it to something.
      # You can set it to anything you want if you also want to provide perSystem outputs in your flake.
      systems = [ "x86_64-linux" ];

      ezConfigs = {
        root = ./.;
        globalArgs = { inherit inputs; };
        nixos.hosts.snowfort.userHomeModules = [ "kiri" ];
      };
    };
}
