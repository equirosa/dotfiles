{ config, pkgs, ... }: {
  home-manager.users.eduardo = {
    programs = {
      fish = {
        enable = true;
        shellAbbrs = {
          "ls" = "ls -h --color=always";
          "l" = "ls -l";
          "ll" = "ls -la";
          "md" = "mkdir -p";
          "g" = "git";
        };
      };
      direnv = {
        enable = true;
        enableFishIntegration = true;
        enableNixDirenvIntegration = true;
      };
      starship = {
        enable = true;
        enableFishIntegration = true;
      };
      keychain = {
        enable = true;
        enableFishIntegration = true;
        agents = [ "ssh" "gpg" ];
        inheritType = "local";
        keys = [
          "sourcehut"
          "github"
          "gitlab"
          "codeberg"
          "azure-devops"
          "vultr-debian"
          "B77F36C3F12720B4"
        ];
      };
    };
  };
  users.users.eduardo.shell = pkgs.fish;
}
