{
  description = "Kiri's Nix configuration";

  inputs = {
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hypr-contrib.inputs.nixpkgs.follows = "nixpkgs";
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprland.url = "github:hyprwm/Hyprland";
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
    inputs @ { emacs-overlay
    , flake-utils
    , home-manager
    , hyprland
    , nix-gaming
    , nix-index-database
    , nixpkgs
    , nixvim
    , wrapper-manager
    , ...
    }:
    let
      colors = import ./colors.nix;
      overlays = [ emacs-overlay.overlay ];
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
            nixpkgs-fmt
            nodePackages.bash-language-server
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
              security.pam.services.swaylock = { };
              nixpkgs.overlays = overlays;
            }
            ./hosts/snowfort/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit colors inputs wrapper-manager overlays; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kiri = { osConfig, ... }: {
                  imports = [
                    ./home
                    hyprland.homeManagerModules.default
                    nix-index-database.hmModules.nix-index
                    nixvim.homeManagerModules.nixvim
                  ];
                  home.stateVersion = osConfig.system.stateVersion;
                };
              };
            }
          ];
          specialArgs = { inherit colors nix-gaming nixpkgs; };
        };
      };
    };
}
