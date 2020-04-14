{ config, ... }: {
  home-manager.users.eduardo = { ... }: {
    programs.keychain = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      agents = [ "ssh" ];
      keys = [ "sourcehut" "github" "gitlab" "codeberg" ];

    };
  };
}
