{
  imports = [ ./default.nix ];
  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 34560000;
      maxCacheTtl = 34560000;
      enableScDaemon = false;
      enableSshSupport = true;
      pinentryFlavor = "gnome3";
      extraConfig = ''
        allow-emacs-pinentry
        allow-loopback-pinentry
      '';
    };
    udiskie.enable = true;
  };
}
