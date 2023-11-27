{ self, lib, ... }: {
  flake = {
    homeModules = {
      common = {
        imports = [ ./shell ./programs ];
        programs = {
          nix-index-database.comma.enable = true;
          nix-index.enable = true;
        };
        nixpkgs.config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [ "vscode" ];
      };
      linux = {
        imports = [ self.homeModules.common ];
      };
      darwin = {
        imports = [ self.homeModules.common ];
      };
    };
  };
}
