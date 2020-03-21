{config, pkgs, ...}: {
  home-manager.users.eduardo = {pkgs, ...}: {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
