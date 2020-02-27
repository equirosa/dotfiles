{ config, ... }: {
  home-manager.users.eduardo = { ... }: {
    home = {
      file.scripts = {
        executable = true;
        recursive = true;
        source = ./scripts;
        target = "/home/eduardo/.local/share/bin";
      };
    };
  };
  environment.sessionVariables = {
    PATH = "/home/eduardo/.local/share/bin:PATH";
  };
}
