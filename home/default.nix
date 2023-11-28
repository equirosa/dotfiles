{ self, lib, inputs, ... }: {
  flake = {
    homeModules = {
      common = {
        imports = [
          inputs.nix-index-database.hmModules.nix-index
          ./programs
          ./shell
        ];
        programs = {
          nix-index-database.comma.enable = true;
          nix-index.enable = true;
        };
        home-manager = {
          backupFileExtension = "hmBackup";
          useGlobalPkgs = true;
          useUserPackages = true;
        };
        nixpkgs.config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [ "vscode" ];
      };
      linux = {
        imports = [
          self.homeModules.common
          inputs.nix-colors.homeManagerModules.default
          ./linux.nix
        ];
      };
      darwin = {
        imports = [ self.homeModules.common ];
        home-manager.home = {
          username = "kiri";
          homeDirectory = lib.mkForce "/Users/kiri";
          stateVersion = "23.11";
        };
      };
    };
  };
}
