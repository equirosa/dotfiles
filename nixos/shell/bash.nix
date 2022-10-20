{ ... }: {
  home-manager.users.kiri = {
    programs = {
      bash = {
        enable = true;
        shellAliases = builtins.removeAttrs (import ./abbreviations.nix) [ "l" "ll" ];
      };
    };
  };
}
