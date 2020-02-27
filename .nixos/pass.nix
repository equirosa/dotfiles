{ config, pkgs, ... }: {
  environment = {
    shellAliases = {
      gp = "gopass";
    };
    variables = {
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    };
  };
  home-manager.users.eduardo = { pkgs, ... }: {
    home = {
      file.gopassConfig = {
        source = ./config/gopass/config.yml;
        target = ".config/gopass/config.yml";
      };
      packages = [ pkgs.gopass ];
    };
    programs.password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: with exts; [
        pass-otp
      ]);
    };
  };
}
