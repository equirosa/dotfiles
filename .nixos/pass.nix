{ config, pkgs, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    home = { packages = [ pkgs.gopass ]; };
    programs.password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: with exts; [ pass-otp ]);
    };
  };
}
