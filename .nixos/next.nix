{ config, pkgs, ... }: {
  environment.systemPackages = [ pkgs.next ];
  home-manager.users.eduardo = { pkgs, ... }: {
    home.file.nextConfig = {
      source = ./config/next.lisp;
      target = ".config/next/init.lisp";
    };
  };
}
