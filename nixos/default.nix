{ self, config, ... }: {
  flake = {
    nixosModules = {
      common.imports = [ ../hosts/snowfort/configuration.nix ];
      my-home = {
        users.users.${config.people.myself}.isNormalUser = true;
        home-manager.users.${config.people.myself} = {
          imports = [ self.homeModules.linux ];
        };
      };
      default.imports = [
        self.nixosModules.home-manager
        self.nixosModules.my-home
        self.nixosModules.common
      ];
    };
  };
}
