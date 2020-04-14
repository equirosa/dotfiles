{ config, ... }: {
  home-manager.users.eduardo = { ... }: {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = {
        battery = {
          full_symbol = "";
          charging_symbol = "";
          discharging_symbol = "";
        };
        git_branch.symbol = " ";
        golang.symbol = " ";
        haskell.symbol = " ";
        nix_shell.symbol = " ";
        package.symbol = " ";
        python.symbol = " ";
        rust.symbol = " ";
      };
    };

  };
}
