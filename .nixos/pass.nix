{ config, pkgs, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    home = {
      packages = [ pkgs.gopass ];
      sessionVariables = {
        PASSWORD_STORE_DIR = "~/.local/share/password-store";
      };
    };
    programs.password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: with exts; [
        pass-otp
      ]);
    };
  };
}
