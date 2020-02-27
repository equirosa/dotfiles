{ config, pkgs, ... }: {
  environment = {
    interactiveShellInit =''
      eval "$(starship init $0)"
    '';
  };
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = {
        hostname = {
          prefix = "❄";
          ssh_only = false;
          style = "bold blue";
          suffix = "❄";
        };
        #python = {
          #symbol = "  ";
        #};
        #rust = {
          #symbol = "  ";
        #};
        username = {
          disabled = false;
          show_always = true;
          style_root = "bold red";
          style_user = "bold yellow";
        };
      };
    };
  };
}
